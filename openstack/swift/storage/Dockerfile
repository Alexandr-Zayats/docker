FROM centos:latest

RUN yum install -y https://www.rdoproject.org/repos/rdo-release.rpm \
    && yum -y update \
    && yum -y install \
    net-tools \
#    python-setuptools \
    xfsprogs rsync \
    openstack-swift-account \
    openstack-swift-container \
    openstack-swift-object \
    && easy_install supervisor \
    && mkdir -p /srv/node/sdb \
    && mkdir -p /srv/node/sdc \
#    && curl -o /etc/swift/account-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/account-server.conf-sample?h=stable/queens \
#    && curl -o /etc/swift/container-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/container-server.conf-sample?h=stable/queens \
#    && curl -o /etc/swift/object-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/object-server.conf-sample?h=stable/queens
    && chown -R swift:swift /srv/node \
    && mkdir -p /var/cache/swift \
    && chown -R root:swift /var/cache/swift \
    && chmod -R 775 /var/cache/swift

ADD rsyncd.conf /etc/rsyncd.conf
ADD supervisord.conf /etc/supervisord.conf
ADD configs/ /etc/swift/
ADD entrypoint.sh /usr/bin/entrypoint

EXPOSE 6200 6201 6202

#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
#CMD ["/usr/bin/swift-object-replicator", "/etc/swift/object-server.conf"]
CMD ['/usr/bin/entrypoint']
