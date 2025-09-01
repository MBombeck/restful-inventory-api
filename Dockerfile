# Use lightweight Node.js image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Install dependencies first for better caching
COPY package*.json ./
ENV NODE_ENV=production
RUN npm ci --omit=dev --legacy-peer-deps --no-audit --fund=false

# Copy application source
COPY . .

# Expose API port
EXPOSE 3000

# Launch the server
CMD ["npm", "start"]
