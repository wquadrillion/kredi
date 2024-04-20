# Base image for Node.js application
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (if using npm)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application code
COPY . .

# Build stage (optional, if needed for building assets)
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy the application code (already copied in builder stage)
COPY . .

# Expose the port where the application listens
EXPOSE 3000

# Start the application (replace 'node app.js' with your actual command)
CMD [ "node", "app.js" ]
