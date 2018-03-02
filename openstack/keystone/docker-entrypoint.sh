#!/bin/sh

conf_path="/etc/keystone/keystone.conf"

if [ $KEYSTONE_DATABASE_CONNECTION ]
then
    crudini --set $conf_path database connection $KEYSTONE_DATABASE_CONNECTION
fi

if [ $KEYSTONE_CACHE_MEMCACHE_SERVERS ]
then
    crudini --set $conf_path database memcache_servers $KEYSTONE_CACHE_MEMCACHE_SERVERS
fi

chown -R root:keystone /etc/keystone

keystone-manage db_sync
keystone-manage fernet_setup --keystone-user root --keystone-group root
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone
#keystone-manage bootstrap
keystone-manage bootstrap --bootstrap-password arvini \
  --bootstrap-admin-url http://keystone:35357/v3/ \
  --bootstrap-internal-url http://keystone:5000/v3/ \
  --bootstrap-public-url http://keystone:5000/v3/ \
  --bootstrap-region-id RegionOne

exec "$@"
