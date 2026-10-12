FROM alpine:3.20

RUN apk add --no-cache \
    bash \
    coreutils \
    iputils \
    bind-tools

WORKDIR /app

COPY app/ /app/

RUN chmod +x /app/*.sh

ENTRYPOINT ["/app/diagnostic.sh"]
