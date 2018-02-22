FROM alpine:3.7

MAINTAINER Alexandr Zayats  <alzay@ciklum.com>

RUN addgroup -S keystone && adduser -S -G keystone keystone

#ADD requirements.txt /tmp/requirements.txt

RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk add --update --no-cache python bash mysql-client \
	&& apk add --no-cache --virtual .fetch-deps \
		git \
		python-dev \
        py-pip \
        gcc \
        musl-dev \
		libc-dev \
        libxml2-dev \
        libxslt-dev \
        libffi-dev \
        openssl-dev \
        g++ \
        gfortran \
        build-base \
        freetype-dev \
        libpng-dev \
		linux-headers \
        openblas-dev \
	&& pip install netifaces --no-clean \
	&& pip install git+https://github.com/openstack/keystone.git@13.0.0.0rc1 \
	&& mkdir /tmp/lib \
	&& cp -rf /usr/lib/lib* /tmp/lib/ \
	&& apk del .fetch-deps \
	&& mv /tmp/lib/* /usr/lib/

COPY docker-entrypoint.sh /entrypoint.sh
COPY etc /etc/keystone/

RUN chown -R keystone: /etc/keystone
USER keystone

ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 5000
EXPOSE 35357
CMD ["keystone-all"]
