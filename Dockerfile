ARG CADDY_VERSION

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder
RUN xcaddy build \
  --with github.com/caddy-dns/cloudflare

FROM dhi.io/caddy:2

ENV XDG_CONFIG_HOME=/config XDG_DATA_HOME=/data
COPY --from=builder /usr/bin/caddy /usr/local/bin/caddy

USER 65532:65532

ENTRYPOINT ["caddy"]
CMD ["run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
