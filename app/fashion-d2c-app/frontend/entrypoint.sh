#!/bin/sh

set -e

envsubst '${BACKEND_HOST} ${BACKEND_PORT} ${ENVIRONMENT}' \
< /etc/nginx/templates/default.conf.template \
> /etc/nginx/conf.d/default.conf

echo "Starting Nginx..."

exec nginx -g "daemon off;"