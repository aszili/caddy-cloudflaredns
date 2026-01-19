ARG CADDY_VERSION=2

FROM caddy:2.10.2-builder-alpine AS builder
RUN xcaddy build \
  --with github.com/caddy-dns/cloudflare

FROM gcr.io/distroless/static-debian12:nonroot

ENV XDG_CONFIG_HOME=/config XDG_DATA_HOME=/data
COPY --from=builder --chown=nonroot:nonroot /usr/bin/caddy /usr/bin/caddy

USER nonroot

ENTRYPOINT ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
