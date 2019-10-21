FROM node:12.12.0-alpine as build-step

# maintainer email Config
MAINTAINER My Name  "manonair20@gmail.com"

# stage 1 build step
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build 

# Stage 2 - Prod set up
FROM nginx:1.17.4-alpine as prod-stage
COPY --from=build-step /app/dist/angularApp /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# health check Config

#HEALTHCHECK --interval=5s \
 #           --timeout=5s \
 #           CMD curl -f http://127.0.0.1:80|| exit 1
