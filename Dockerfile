# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80

#docker run --name some-nginx -d -p 8080:80 some-content-nginx
# docker create -p 8080:80 ff9e
