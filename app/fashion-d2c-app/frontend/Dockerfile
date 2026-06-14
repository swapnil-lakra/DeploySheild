# Stage 1: Builder
FROM oven/bun:latest AS builder

WORKDIR /app

COPY package.json bun.lock ./
RUN bun install --freeze-lockfile

COPY . .

# Build karo - build time pe environment variable set nahin kar rahe
RUN bun run build

# Stage 2: Runtime
FROM oven/bun:latest AS runner

WORKDIR /app

# .next/standalone aur public files ko copy karo
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./next/static
COPY --from=builder /app/public ./public

# Node modules se next server binary chahiye toh copy karo (agar lazım ho)
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000

# Production environment
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Runtime pe environment variables default values ke saath
# Docker/docker-compose se override ho sakte hain
ENV NEXT_PUBLIC_API_BASE_URL=http://localhost:8000

CMD ["bun", "run", "server.js"]