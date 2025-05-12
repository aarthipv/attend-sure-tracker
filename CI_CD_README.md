
# CI/CD Pipeline with Docker, Prometheus, and Solana

This repository contains a CI/CD pipeline setup for a Solana application with monitoring using Prometheus and Grafana.

## Components

- **Docker**: Used for containerization of the application
- **Prometheus**: For monitoring and metrics collection
- **Grafana**: For metrics visualization
- **GitHub Actions**: For CI/CD workflow
- **Solana Tools**: For interacting with Solana blockchain

## Setup Instructions

### Prerequisites

- Docker and Docker Compose
- Node.js and npm
- Solana CLI tools (installed automatically in the containers)
- GitHub account for CI/CD

### Local Development

1. Clone the repository:
   ```
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Start the local development environment:
   ```
   make run
   ```

4. View logs:
   ```
   make logs
   ```

5. Stop the services:
   ```
   make stop
   ```

### CI/CD Pipeline

The CI/CD pipeline automatically runs when:
- Code is pushed to the main branch
- A pull request is opened against the main branch

The pipeline performs the following steps:
1. Builds the application
2. Runs tests
3. If on main branch, builds and pushes a Docker image
4. Deploys to production (needs to be configured)

### Monitoring

- Prometheus is available at http://localhost:9090
- Grafana is available at http://localhost:3000

Initial Grafana login:
- Username: admin
- Password: admin

## Environment Variables

Create a `.env` file with the following variables:
```
SOLANA_RPC_URL=https://api.mainnet-beta.solana.com
```

## Secrets for CI/CD

Add the following secrets to your GitHub repository for the CI/CD workflow:
- `DOCKER_USERNAME`: Your Docker Hub username
- `DOCKER_PASSWORD`: Your Docker Hub password or token

## Common Commands

See the Makefile for common commands.
