#!/bin/bash

IP=$(ifconfig | awk '/inet 172.16/{print $2}')
sed -i "s/MANAGEMENT_INTERFACE_IP_ADDRESS/${IP}/g" /etc/swift/proxy-server.conf

while [ ! -f /etc/swift/initial/object.ring.gz ]
do
    echo "whaiting for ring files"
    sleep 5
done

cp -f /etc/swift/initial/*.ring.gz /etc/swift/
/usr/bin/swift-proxy-server /etc/swift/proxy-server.conf
