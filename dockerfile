# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build Vite project (creates dist/)
RUN npm run build

# Runtime stage
FROM node:20-alpine

WORKDIR /app

# Install simple HTTP server
RUN npm install -g http-server

# Copy built files from builder
COPY --from=builder /app/dist ./dist

# Expose port
EXPOSE 3000

# Start server
CMD ["http-server", "dist", "-p", "3000"]