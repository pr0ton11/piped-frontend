#!/bin/sh
# Entrypoint script for Piped frontend
# Ensures that if environment variable API_ENDPOINT is set, asset endpoint strings gets replaced with this domain

# Log functions from nginx upstream image
set -e

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

ME=$(basename $0)

if [ ! -z "${API_ENDPOINT}" ]; then
    entrypoint_log "${ME}: Using custom api endpoint: ${API_ENDPOINT}..."
    sed -i s/pipedapi.kavin.rocks/${API_ENDPOINT}/g /usr/share/nginx/html/assets/*
fi
