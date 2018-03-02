#!/bin/bash
while [ ! -f /etc/swift/initial/object.ring.gz ]
do
    echo "whaiting for ring files"
    sleep 5
done

cp -f /etc/swift/initial/*.ring.gz /etc/swift/
/usr/bin/swift-proxy-server /etc/swift/proxy-server.conf
