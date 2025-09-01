# Use lightweight Node.js image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Install dependencies first for better caching
COPY package*.json ./
RUN npm install --production

# Copy application source
COPY . .

# Expose API port
EXPOSE 3000

# Launch the server
CMD ["npm", "start"]
