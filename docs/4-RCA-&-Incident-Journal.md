Date - 12/06/2026

# 1. Frontend Docker image build Error - bun.lock not found to copy

## Root Cause of Error :-
Image build karte waqt ishliye Error aaya kyuki docker bun.lock ko app folder me copy karna chahta tha lekin wo bun.lock ko find nahi kar paya kyuki maine bun.lock of .dockerignore me add kar rakha tha iss reason ke wo bun.lock ko ignore kar raha tha.

## Error Resoluton :-
Iss Error ko solve karne ke 2 taarike hai :
1. Mujhe .dockerignore me se bun.lock ko remove karna padega toh docker bun.lock ko ignore nahi karega
2. Ya fir Mujhe Dockerfile me se bun.lock ko remove karna padega taaki wo app folder me copy na ho

Mai Option 1 ko choose kiya hun 

Date - 13/06/2026

# 2. Backend Docker image build Error - Alpine Linux package manager error

## Root Cause of Error:
Image build karte waqt ishliye error occur hua kyuki mere Docker image Alpine Linux (python:3.12-alpine) pe based hai naaki Fedora ya Ubuntu. Alpine `apk` ko apna package manager ke taur pe use karta hai , naaki `dnf` (Fedora/RHEL) or `apt` (Debian/Ubuntu).

```Dockerfile
# Wrong Command according to Alpine Linux
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*
```

## Error Resolution :-
Iss error ko solve karne ke liye mujhe Dockerfile ke command me `apline linux` ka package manager `apk` ko use karna padega kyuki mai apne Dockerfile me `python:3.12-alpine` ko use kiya hai 

```Dockerfile
# Correct Command according to Apline Linux
RUN apk add --no-cache gcc mariadb-dev pkgconfig
```
Date - 14/06/2026

# 3. Frontend Docker image build Error - Environment Variable "undefined" Issue in Docker Build

## Root Cause of Error :
### 1. Build-Time vs Runtime Difference
```text
❌ JYADA hone wala:
Local development:  .env file → NextJS read → Build time pe available
Docker build:       .env file → Docker context mein nahin → Build time pe undefined
```

### Kya ho raha hai:
```javascript
// Server Component mein
const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/products/`);
                        ↑ ye value build time pe hard-coded ho jaata hai
```

Build time pe `process.env.NEXT_PUBLIC_API_URL` evaluate hota hai. Agar `.env` file Docker container mein available nahin hai, toh `undefined` ho jaata hai.

### 2. NEXT_PUBLIC_ Prefix Confusion
`NEXT_PUBLIC_` prefix ka matlab:

- ✅ Client-side mein expose ho sakta hai
- ✅ Build time mein hard-coded ho jaata hai
- ❌ Runtime pe change nahin ho sakta

```javascript
// ye build time mein ye ban jaata hai:
const res = await fetch(`undefined/api/products/`);
// kyunki build time pe undefined tha
```

## Error Resolution :

Maine iss error ko resolve karne ke liye **Runtime Environment Variables** ka use kiya hai jo server side rendering ke liye environment variables ko build time se runtime mein move karta hai.

```javascript
// lib/config.js
export const getApiUrl = () => {
  // Runtime pe check karo, build time nahin
  return process.env.NEXT_PUBLIC_API_URL || 
         'http://localhost:8000';
};
```

```javascript
// app/products/page.js
import { getApiUrl } from '@/lib/config';

export default async function ProductsPage() {
  const apiUrl = getApiUrl(); // Runtime pe call hota hai!
  
  const res = await fetch(`${apiUrl}/api/products/`, {
    cache: "no-store",
  });
  const products = await res.json();
  
  return (
    // ... same JSX
  );
}
```

```Dockerfile
# Runtime pe environment variables default values ke saath
# Docker/docker-compose se override ho sakte hain
ENV NEXT_PUBLIC_API_BASE_URL=http://localhost:8000
```


# 4. Frontend Docker image build Error - Module not found: Can't resolve '@/lib/config'" Error

## Root Cause of Error :
Ye issue TypeScript/JavaScript path alias resolution ka hai. Build time pe `@/` path resolve nahin ho pa raha!

## Error Resolution :

Mai iss error ko resolve karne ke liye relative path ka use kiya hua hu

```javascript

// Build time pe '@/' resolve nahi ho raha hai
import { getApiUrl } from "@/lib/config" ❌

// To resolve this change `@` to '..' relative path
import { getApiUrl } from "../lib/config" ✅
```

# 5. Frontend Docker image build Error - Build Time PE API Connection Refused Error

**Kya hua (What happened):**     Your Next.js build fail ho gaya kyun ke production build ke time pe app ek API endpoint (`http://localhost:8000/api/products/featured?limit=4`) ko access karne ki koshish kar raha tha, lekin woh service available nahi tha.

## Root Cause of Error :
Dockerfile mein **build time pe API calls ho rahe hain** kyun ke:

1. Next.js 13+ default mein static export ya ISR (Incremental Static Regeneration) use kar raha hai
2. Build phase ke doran page `/` ko prerender kar rahe ho
3. Jab prerender ho raha tha, toh page ne featured products fetch karne ke liye API call kiya
4. **Docker container ke andar `localhost:8000` par koi service nahi chal raha tha** → Connection Refused

```Code
❌ Build Phase (Docker ke andar)
  └─ Next.js tries to prerender "/"
    └─ Page calls: http://localhost:8000/api/products/featured
      └─ Connection refused (service doesn't exist)
        └─ Build fails
```

## Error Resolution :

Mai iss error ko resolve karne ke liye mai **Dynamic Rendering** ka use kiya hu jo best hai **API-dependent Pages** ke liye.

```typescript
// ✅ Isko ISR ke bajay dynamic render karo
export const dynamic = 'force-dynamic';
// Ya revalidate set karo
export const revalidate = 60; // 60 seconds

export default async function Home() {
  const res = await fetch('http://localhost:8000/api/products/featured?limit=4', {
    next: { revalidate: 60 }
  });
  const products = await res.json();
  
  return <div>{/* render */}</div>;
}
```

# 6. Docker compose run error - failed to set up container networking

## Error
> **Error response from daemon**: failed to set up container networking: driver failed programming external connectivity on endpoint d2c-mysql (95410553efb0842ac2c6024dd5ebd54683d802beb7473810ab744d4ac471cd79): failed to bind host port 0.0.0.0:3306/tcp: address already in use

## Root Cause Analysis
**Kya hua (What happened)**: Docker compose ne `d2c-mysql` container start karne ki koshish ki, lekin port `3306` (MySQL ka default port) already aapke machine par use ho raha tha.

```Code
❌ Docker trying to bind
  └─ Port: 0.0.0.0:3306/tcp
    └─ Status: "address already in use"
      └─ Reason: Koi aur process/container us port par chal raha hai
```

## Root Cause
**Ek hi wajah ho sakti hai**:

1. **Purana MySQL/MariaDB container still running hai** ← Most likely
2. Local machine par MySQL service already chal rahi hai
## Error Resolution :
Iss error ko resolve karne ke liye mujhe port `3306` ke alawa koi dushra port use karna padega jo already use me nahi ho jaise 3307 ya fir 3308 agar ye use me na ho toh

```yaml
# Port ko flexible banao
ports:
  - "${MYSQL_PORT:-3306}:3306"
  # ✅ Ab 3306 par conflict ho toh MYSQL_PORT env variable se alag port use hoga

# DATABASE_URL fix karo
DATABASE_URL: mysql+aiomysql://root:Password123!@mysql:3306/d2c_fashion?charset=utf8mb4
# ✅ localhost ke bajay 'mysql' (container name) use karo
```

```.env
MYSQL_PORT=3306
# Agar conflict ho toh 3307 ya 3308 kar do
```
Date - 15/06/2026

# 7. Docker Compose run error - dependency failed to start

## Error
> **dependency failed to start**: container d2c-mysql is unhealthy

## Root Cause 
**What Failed:** Container d2c-mysql unhealthy status mein tha → backend depends_on condition fail → entire stack fail

Ye error occur hone ke 2 sabse bade reasons hai:
1. Primary Issue: Volume Mount Path Bug ⭐⭐⭐
2. Secondary Issue: Healthcheck Test Command ⭐⭐

###  Primary Issue: Volume Mount Path Bug ⭐⭐⭐

```yaml
# ❌ WRONG:
- ./mysql-init:/docker-entrypoint-initdb.d/init.sql
```

- docker-entrypoint-initdb.d ek directory hai jisme saare .sql file run hote hai 
- Volumne mount me mistake hua kyuki ./mysql-init ek folder hai aur wo ek file ke saath mount hua 
- Jisse database initialization script run nahi hua


### Secondary Issue: Healthcheck Test Command ⭐⭐

```yaml
# Healthcheck command:
test: ["CMD","mysqladmin", "ping", "-h", "localhost", "-u", "root", "-p${MYSQL_ROOT_PASSWORD}"]
```
- Healthcheck ki test command me .env variable apne values se replace nahi hote hai jo unka variable name hota hai wo as it is reh jaate hai
- jisse healthcheck test fail ho jaata hai aur fir wo unhealthy ho jaata hai
- fir backend ko dikkat ho jata hai kyuki wo mysql database pe depend karta hai
 

## Error Resolving

### 1. Volume Mount
- Always mount Directory to Directory that is recommended

```yaml
# ❌ WRONG (Before):
- ./mysql-init:/docker-entrypoint-initdb.d/init.sql

# ✅ CORRECT (After):
- ./mysql-init:/docker-entrypoint-initdb.d
```

### 2. Healthcheck Test Command

- Environment variable healthcheck test me work nahi karte 
- Ishiliye simple connectivity check karna chahiye jisme authentication ki need na ho

```yaml
# ❌ Wrong (Before) :
test: ["CMD","mysqladmin", "ping", "-h", "localhost", "-u", "root", "-p${MYSQL_ROOT_PASSWORD}"]

# ✅ CORRECT (After) :
test: ["CMD", "mariadb-admin", "ping", "-h", "127.0.0.1", "--silent"]
```

## Complete Cause Chain (Diagram):
```code
┌─────────────────────────────────────────────────────────┐
│ ROOT CAUSE: Wrong Volume Mount Path                     │
│ ./mysql-init:/docker-entrypoint-initdb.d/init.sql       │
└──────────────────┬──────────────────────────────────────┘
                   │
        ┌──────────▼──────────┐
        │ Mount Fails Silently│
        └──────────┬──────────┘
                   │
        ┌──────────▼────────────────────┐
        │ init.sql Not Found/Executed   │
        │ Database Creation Incomplete  │
        └──────────┬────────────────────┘
                   │
        ┌──────────▼─────────────────────┐
        │ MySQL Starts But Inconsistent  │
        │ State (Missing DB/Tables)      │
        └──────────┬─────────────────────┘
                   │
        ┌──────────▼──────────────────────────────┐
        │ SECONDARY: Healthcheck Test Fails       │
        │ Password var doesn't expand in healthcheck
        │ mysqladmin authentication error          │
        └──────────┬──────────────────────────────┘
                   │
        ┌──────────▼──────────────────────┐
        │ Container Marked UNHEALTHY      │
        └──────────┬──────────────────────┘
                   │
        ┌──────────▼──────────────────────┐
        │ Backend depends_on mysql:healthy│
        │ Condition NOT MET               │
        └──────────┬──────────────────────┘
                   │
        ┌──────────▼──────────────────────┐
        │ ❌ dependency failed to start:  │
        │    container d2c-mysql unhealthy
        │                                  │
        │ Frontend also fails              │
        └──────────────────────────────────┘
```

---
---

Date - 19/06/2026

# 8. CI/CD Pipeline broken becaue docker image build failed

## Error
### Backend docker image build error
ERROR: failed to build: invalid tag "ghcr.io/swapnil-lakra//fastapi-backend:latest": invalid reference format

### Frontend docker image build error
ERROR: failed to build: invalid tag "ghcr.io/swapnil-lakra//nextjs-frontend:latest": invalid reference format

## Root Cause
- Iss pipeline break hone ka main reason hai invalid tag docker image ko assign karna

- "ghcr.io/swapnil-lakra//nextjs-frontend:latest" ❌

- "ghcr.io/swapnil-lakra//fastapi-backend:latest" ❌

Aur invalid tag hone ka main reason hai - invalid github context
```yaml
# frontend tag ❌
env:
  GHCR_REGISTRY: ghcr.io/${{ github.repository_owner }}
  FRONTEND_IMAGE: ${{ github.respository_name }}/nextjs-frontend ❌

# backend tag ❌
env:
  GHCR_REGISTRY: ghcr.io/${{ github.repository_owner }}
  BACKEND_IMAGE: ${{ github.repository_name }}/fastapi-backend ❌
```

`github.repsitory_name` invalid hai kyuki yeh exist hi nahi karta hai

## Error Resolving

Iss broken ci/cd pipeline ko repair karne ke liye valid github context provide karna padega jisse ki valid tag assign ho docker image ko

```yaml

# frontend tag
env:
  GHCR_REGISTRY: ghcr.io/${{ github.repository_owner }}
  FRONTEND_IMAGE: ${{ github.respository_name }}/nextjs-frontend ❌
  FRONTEND_IMAGE: ${{ github.event.repository.name }}/nextjs-frontend ✅

# backend tag
env:
  GHCR_REGISTRY: ghcr.io/${{ github.repository_owner }}
  BACKEND_IMAGE: ${{ github.repository_name }}/fastapi-backend ❌
  BACKEND_IMAGE: ${{ github.event.repository.name }}/fastapi-backend ✅
```
