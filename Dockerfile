ARG CADDY_VERSION=2

FROM caddy:2.10.0-builder-alpine AS builder
RUN xcaddy build \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/mholt/caddy-webdav

FROM caddy:2.10.0-alpine
RUN apk add --no-cache tzdata
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
