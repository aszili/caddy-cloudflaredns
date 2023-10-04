ARG CADDY_VERSION=2

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder
RUN xcaddy build \
  --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}-alpine
RUN apk add --no-cache tzdata
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
