#!/bin/bash

if [ -z "$KEYSTONE_DB_PASSWORD" ]; then
    echo >&2 'error: missing KEYSTONE_DB_PASSWORD environment variable'
    exit 1
fi

MYSQL_SERVICE_HOST=${MYSQL_SERVICE_HOST:-$SERVICE_HOST}

if [ -z "$MYSQL_SERVICE_HOST" ]; then
    echo >&2 'error: Keystone requires access to a MySQL database'
    exit 1
fi

KEYSTONE_DB_USER=${KEYSTONE_DB_USER:-keystone}
KEYSTONE_DB_NAME=${KEYSTONE_DB_NAME:-keystone}

if [[ -z "$(mysql -uroot -p"${MYSQL_ROOT_PASSWD}" -h ${MYSQL_SERVICE_HOST} -s -qfsBe  "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='${KEYSTONE_DB_NAME}'" 2>&1)" ]];
then
    mysql -uroot -p"${MYSQL_ROOT_PASSWD}" -h ${MYSQL_SERVICE_HOST} -e "CREATE DATABASE ${KEYSTONE_DB_NAME} CHARACTER SET UTF8; \
    GRANT ALL PRIVILEGES ON ${KEYSTONE_DB_NAME}.* TO '${KEYSTONE_DB_USER}'@'%' IDENTIFIED BY '${KEYSTONE_DB_PASSWORD/g}';"
fi

sed -e "s/%DB_USER%/$KEYSTONE_DB_USER/g" \
    -e "s/%DB_PASSWORD%/$KEYSTONE_DB_PASSWORD/g" \
    -e "s/%DB_NAME%/$KEYSTONE_DB_NAME/g" \
    -e "s/%DB_HOST%/$MYSQL_SERVICE_HOST/g" \
    -i /etc/keystone/keystone.conf

keystone-manage db_sync

exec "$@"
