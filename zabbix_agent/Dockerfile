#FROM alpine:3.7
FROM bhuisgen/alpine-base:latest

ENV ZABBIX_VERSION=3.2.4

COPY packages/*.apk /root/
RUN apk add --update git python3 && \
    apk add --allow-untrusted \
        /root/zabbix-agent-${ZABBIX_VERSION}-*.apk && \
    python3 -m ensurepip --upgrade && \
    git clone --depth 1 --progress https://github.com/bhuisgen/zabbix-docker.git /usr/local/zabbix-docker && \
    cd /usr/local/zabbix-docker && \
    python3 setup.py install && \
    apk del git && \
    rm -f /root/*.apk && \
    rm -rf /var/cache/apk/*

COPY rootfs/ /

ENTRYPOINT ["/init"]
CMD []

EXPOSE 10050
VOLUME ["/var/lib/zabbix"]
