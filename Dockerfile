
FROM node:18-alpine AS builder

WORKDIR /app

# Copy project files
COPY . .

# Install dependencies and build
RUN npm install
RUN npm run build

# Production stage
FROM node:18-alpine AS production
WORKDIR /app

COPY --from=builder /app/build /app/build
COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builder /app/package.json /app/package.json

EXPOSE 8080

CMD ["npm", "run", "start"]
