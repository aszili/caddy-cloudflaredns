ARG CADDY_VERSION=2

FROM caddy:2.10.2-builder-alpine AS builder
RUN xcaddy build \
  --with github.com/caddy-dns/cloudflare

FROM caddy:2.10.2-alpine AS caddy

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

FROM gcr.io/distroless/static-debian12:nonroot

ENV XDG_CONFIG_HOME=/config XDG_DATA_HOME=/data

COPY --from=caddy --chown=nonroot:nonroot /usr/bin/caddy /usr/bin/caddy
COPY --from=caddy --chown=nonroot:nonroot /data/caddy /data/caddy

USER nonroot

ENTRYPOINT ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
