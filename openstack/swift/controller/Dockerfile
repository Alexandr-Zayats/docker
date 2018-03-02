FROM centos:latest

RUN yum install -y https://www.rdoproject.org/repos/rdo-release.rpm \
    && yum -y update \
    && yum install -y \
	openstack-swift-proxy \
	python-swiftclient \
	python-keystoneclient \
	python-keystonemiddleware
#	memcached \
#	vim
#    curl -o /etc/swift/proxy-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/proxy-server.conf-sample?h=stable/queens

EXPOSE 8080

ADD proxy-server.conf /etc/swift/proxy-server.conf
ADD entrypoint.sh /usr/bin/entrypoint

CMD ['/usr/bin/entrypoint']
