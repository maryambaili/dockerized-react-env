# Stage 1
ARG NODE_VERSION
FROM node:${NODE_VERSION} as dev
WORKDIR /app
COPY package*.json ./
RUN yarn install
 

# Dev environment doesn't run this stage or beyond
FROM dev as prod
COPY public public/
COPY src src/
RUN yarn build


# Stage 2 - the production environment
ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}
#COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=prod /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]; \









