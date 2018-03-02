FROM alpine:3.7

ARG depends="py-pip mariadb-client-libs"
ARG make_depends="build-base git libffi-dev linux-headers mariadb-dev python-dev"
ARG repository="https://git.openstack.org/openstack/keystone.git"
ARG tag="13.0.0.0rc1"
# openssl-dev

WORKDIR /opt/keystone
#RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
RUN apk add --no-cache $depends \
	&& addgroup -S keystone \
	&& adduser -D -S -h /etc/keystone -s /sbin/nologin -G keystone keystone \
	&& apk add --no-cache $make_depends \
	&& git clone $repository .\
	&& git checkout -b $tag refs/tags/$tag\
	&& pip install --no-cache-dir --upgrade pip\
	&& pip install --no-cache-dir .\
	&& pip install --no-cache-dir MySQL-python mysql-python mysqlclient crudini python-memcached PyMySQL uwsgi amqp==2.2.2 kombu>=4.0.3 pika==0.10\
	&& mkdir -p /etc/keystone\
	&& mv etc/* /etc/keystone/\
#	&& mv /etc/keystone/keystone.conf.sample /etc/keystone/keystone.conf\
	&& sed -i "s/ admin_token_auth / 9a75f87f00116079c422 /" /etc/keystone/keystone-paste.ini\
	&& apk del --no-cache $make_depends\
	&& rm -rf /opt/keystone \
	&& chown -R root:keystone /etc/keystone
	
ADD keystone.conf /etc/keystone/keystone.conf
ADD docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]

CMD uwsgi --http :5000 --wsgi-file $(which keystone-wsgi-public)

EXPOSE 5000 35357
