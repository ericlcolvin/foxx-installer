FROM gliderlabs/alpine:latest

RUN apk add --update curl && \
    apk add zip && \
    apk add jq && \
    rm -rf /var/cache/apk/*

COPY ./app/ /app/
COPY ./install_foxx.sh /home

ENTRYPOINT ["/home/install_foxx.sh"]
