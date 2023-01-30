FROM node:lts-alpine as build

ENV SOURCE_REPO https://github.com/TeamPiped/Piped.git

WORKDIR /app

RUN --mount=type=cache,target=/var/cache/apk \
    apk add --no-cache \
    curl \
    git \
    grep

RUN --mount=type=cache,target=/root/.cache/yarn \
    git clone ${SOURCE_REPO} /app/Piped && \
    cd /app/Piped && \
    yarn install --prefer-offline && \
    yarn build && \
    ./localizefonts.sh

FROM nginx:alpine
LABEL maintainer "Marc Singer <ms@pr0.tech>"

COPY --from=build /app/Piped/dist/ /usr/share/nginx/html/

COPY entrypoint.sh /docker-entrypoint.d/40-piped.sh
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
