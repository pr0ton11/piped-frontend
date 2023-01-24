FROM node:lts-alpine as build

ARG REPO https://github.com/TeamPiped/Piped.git

WORKDIR /app

RUN --mount=type=cache,target=/var/cache/apk \
    apk add --no-cache \
    curl \
    git

RUN --mount=type=cache,target=/root/.cache/yarn \
    --mount=type=cache,target=/app/ \
    --mount=type=cache,target=/app/node_modules \
    git clone REPO /app && \
    yarn install --prefer-offline && \
    yarn build && \
    ./localizefonts.sh

FROM nginx:alpine

COPY --from=build /app/dist/ /usr/share/nginx/html/

COPY entrypoint.sh /docker-entrypoint.d/40-piped.sh
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
