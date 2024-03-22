# Stage 1: Build React.js application
FROM node:21.7.1-alpine3.18 as build-stage
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --force
COPY . .
RUN npm run build 

# Stage 2: Serve React.js application using Nginx
FROM nginx:stable-alpine3.17
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
