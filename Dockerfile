ARG CADDY_VERSION=2

FROM caddy:2.9-builder-alpine AS builder
RUN xcaddy build \
  --with github.com/caddy-dns/cloudflare

FROM caddy:2.9-alpine
RUN apk add --no-cache tzdata
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
