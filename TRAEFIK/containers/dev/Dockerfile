FROM centos:7
RUN yum update -y
 
#Install php
RUN yum -y update && yum -y install epel-release && \
	sed -i -e "\|^https://\"http://|d" /etc/yum.repos.d/epel.repo && \
	rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
	yum -y install yum-utils && \
	yum -y update

RUN yum-config-manager --enable remi-php71 && \
	yum -y install php php-opcache php-mysql 

#	yum -y install php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-soap curl curl-devel

RUN yum -y install wget vim sshd mysql

RUN yum clean all 

RUN mkdir /data
COPY .bashrc /root/
COPY .vimrc /root/
ADD start.sh /
ENTRYPOINT /start.sh
