# Stage 1: Build React.js application
FROM node:21-alpine3.17 as build-stage
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --force
COPY . .
RUN npm run build || { echo "Build failed"; exit 1; }

# Stage 2: Serve React.js application using Nginx
FROM nginx:1.23.3-alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
