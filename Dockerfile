# Use latest Node.js image
FROM node:latest

# Set working directory inside the container
WORKDIR /apps

# Copy package.json and package-lock.json first (to optimize caching)
# COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the remaining app files to the container
COPY . .

# Expose the port (Change 3000 if needed)
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]
