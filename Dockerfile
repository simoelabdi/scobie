# Step 1: Build the React app
FROM node:18 as build
 
WORKDIR /app
 
# Copy package.json and package-lock.json
COPY package*.json ./
 
# Install dependencies
RUN npm install
 
# Copy the rest of the app's source code
COPY . .
 
# Build the app
RUN npm run build
 
# Step 2: Serve the app using a lightweight web server
FROM nginx:alpine
 
# Copy the build files from the previous stage to the NGINX html directory
COPY --from=build /app/build /usr/share/nginx/html
 
# Expose port 80
EXPOSE 80
 
# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]