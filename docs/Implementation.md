Date - 12/06/2026

## 1. d2c-fashion-app ko containerize karne ke liye mai frontend aur backed dono ke liye Dockerfile aur .dockerigore file bana ke likh li hai

Date - 14/06/2026

## 2. frontend ke liye docker image create kiya gaya hai.

```bash
cd app/fashion-d2c-app/frontend

docker build -t nextjs-frontend .
```
aur usko mai error aur uska resolution ko 4-RCA-&-Incident-Journal.md me point no. 1,3,4,5 me document kiya hua hai


## 3. backend ke liye docker image create kiya gaya hai.

```bash
cd app/fashion-d2c-app/backend

docker build -t fastapi-backend
```

aur usko mai error aur usko resolution ko 4-RCA-&-Incident-Journal.md me point no. 2 me document kiya hua hai

Date - 15/06/2026

## 4. d2c fashion application ke liye `docker compose` run kiya gaya hai

```bash
cd app/fashion-d2c-app

docker compose up -d
```

aur usko mai error aur usko resolution ko 4-RCA-&-Incident-Journal.md me point no. 6 aur 7 me document kiya hua hai

## 5. D2C fashion application ke frontend and backend ke docker images ko GHCR(GitHub Container Registry) me push kiya gaya hai

 Push karne se phele Docker Images ko tag karna padega GHCR registry URL structure me and strict naming convention ke saath 

```bash
# tagging frontend image
docker tag nextjs-frontend:latest ghcr.io/swapnil-lakra/deploysheild/nextjs-frontend:latest 

# tagging backend image
docker tag fastapi-backend:latest ghcr.io/swapnil-lakra/deploysheild/fastapi-backend:latest
```

d2c fashion application ke frontend and backend ka docker images ko GHCR(GitHub Container Registry) me push ho gaya 

```bash
# push frontend docker image to GHCR
docker push ghcr.io/swapnil-lakra/deploysheild/nextjs-frontend:latest

# push backend docker image to GHCR
docker push ghcr.io/swapnil-lakra/deploysheild/fastapi-backend:latest
```

Date - 16/06/2026

