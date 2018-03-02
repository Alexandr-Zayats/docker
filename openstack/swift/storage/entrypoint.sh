#!/bin/bash

IP=$(ifconfig | awk '/inet 172.16/{print $2}')
sed -i "s/MANAGEMENT_INTERFACE_IP_ADDRESS/${IP}/g" /etc/rsyncd.conf
sed -i "s/MANAGEMENT_INTERFACE_IP_ADDRESS/${IP}/g" /etc/swift/account-server.conf
sed -i "s/MANAGEMENT_INTERFACE_IP_ADDRESS/${IP}/g" /etc/swift/container-server.conf
sed -i "s/MANAGEMENT_INTERFACE_IP_ADDRESS/${IP}/g" /etc/swift/object-server.conf

mkdir -pv /srv/node/sdb
mkdir -pv /srv/node/sdc

echo "RSYNC_ENABLE=true" >>/etc/default/rsync
echo $IP >>/etc/swift/initial/iplist

cd /etc/swift
if [ -f /etc/swift/initial/preparation.fl ]; then
    while [ -f /etc/swift/initial/preparation.fl ]
    do
        echo "whaiting for configuration"
        sleep 5
    done
else 
    touch /etc/swift/initial/preparation.fl
	rm -f /etc/swft/initial/*.ring.gz
    sleep 30
    ips=$(sort -u /etc/swift/initial/iplist)
    if [ ! -f /etc/swft/initial/account.ring.gz ]; then
        # Create account ring
        swift-ring-builder account.builder create 10 3 1
        i=0
        for ip in $ips; do
#            ip=$(getent hosts storage.${i} | cut -d" " -f1)
            if [ -n "$ip" ]; then
                ((i = i + 1))
                echo "IP: $ip; I: $i"
                swift-ring-builder account.builder add r1z$i-$ip:6202/sdb_"" 100 # --region 1 --zone $i --ip Sip --port 6202 --device sdb --weight 100
                swift-ring-builder account.builder add r1z$i-$ip:6202/sdc_"" 100
            fi
        done
        swift-ring-builder account.builder
        swift-ring-builder account.builder rebalance
        cp -f account.ring.gz /etc/swift/initial/
    fi
    if [ ! -f /etc/swft/initial/container.ring.gz ]; then
        # Create container ring¶
        swift-ring-builder container.builder create 10 3 1
        i=0
        for ip in $ips; do
            if [ -n "$ip" ]; then
                ((i = i + 1))
                swift-ring-builder container.builder add r1z$i-$ip:6201/sdb_"" 100
                swift-ring-builder container.builder add r1z$i-$ip:6201/sdc_"" 100
            fi
        done
        swift-ring-builder container.builder
        swift-ring-builder container.builder rebalance
        cp -f container.ring.gz /etc/swift/initial/
    fi
    if [ ! -f /etc/swft/initial/object.ring.gz ]; then
        # Create object ring
        swift-ring-builder object.builder create 10 3 1
        i=0
        for ip in $ips; do
            if [ -n "$ip" ]; then
                ((i = i + 1))
                swift-ring-builder object.builder add r1z$i-$ip:6201/sdb_"" 100
                swift-ring-builder object.builder add r1z$i-$ip:6201/sdc_"" 100
            fi
        done
        swift-ring-builder object.builder
        swift-ring-builder object.builder rebalance
        cp -f object.ring.gz /etc/swift/initial/
    fi
    rm /etc/swift/initial/preparation.fl
    rm /etc/swift/initial/iplist
fi

mkdir -p /var/cache/swift /var/cache/swift2 /var/cache/swift3 /var/cache/swift4
chown swift:swift /var/cache/swift*
mkdir -p /var/run/swift
chown swift:swift /var/run/swift

cp -f /etc/swift/initial/*.ring.gz /etc/swift/
chown -R root:swift /etc/swift

rsync --daemon --config=/etc/rsyncd.conf
/usr/bin/supervisord -c /etc/supervisord.conf
