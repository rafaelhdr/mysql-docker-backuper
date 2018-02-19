FROM alpine:3.6

RUN apk add --no-cache mysql-client py-pip && \
    pip install awscli

ADD ["entrypoint.sh", "wait-for", "export.sh", "/"]

CMD ["/bin/sh", "/entrypoint.sh"]
