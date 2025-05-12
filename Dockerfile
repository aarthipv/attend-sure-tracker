
FROM node:18-alpine AS builder

WORKDIR /app

# Install Solana CLI tools
RUN apk add --no-cache curl bash jq
RUN sh -c "$(curl -sSfL https://release.solana.com/v1.17.0/install)"
ENV PATH="/root/.local/share/solana/install/active_release/bin:$PATH"

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
COPY --from=builder /root/.local/share/solana /root/.local/share/solana
ENV PATH="/root/.local/share/solana/install/active_release/bin:$PATH"

EXPOSE 8080

CMD ["npm", "run", "start"]
