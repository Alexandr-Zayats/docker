#!/bin/bash

set -e

es_opts=''

while IFS='=' read -r envvar_key envvar_value
do
    # Elasticsearch env vars need to have at least two dot separated lowercase words, e.g. `cluster.name`
    if [[ "$envvar_key" =~ ^[a-z]+\.[a-z]+ ]]
    then
        if [[ ! -z $envvar_value ]]; then
          es_opt="-E${envvar_key}=${envvar_value}"
          es_opts+=" ${es_opt}"
        fi
    fi
done < <(env)

set -- elasticsearch "$@"

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@" ${es_opt}
fi

export BASE='/usr/share/elasticsearch'
CONFIG=${BASE}/config/elasticsearch.yml

# = MASTER NODE =                              #
if [ "$1" = 'master' -a "$(id -u)" = '0' ]; then
	# Change node into a data master
	sed -ri "s!^(\#\s*)?(node\.master:).*!\2 true!" $CONFIG
    sed -ri "s!^(\#\s*)?(node\.ingest:).*!\2 false!" $CONFIG
    sed -ri "s!^(\#\s*)?(node\.data:).*!\2 false!" $CONFIG

	echo "node.name: [\"es-master-01\"]" >> $CONFIG
	for path in \
	    /usr/share/elasticsearch/data \
	    /usr/share/elasticsearch/logs \
	    /usr/share/elasticsearch/config \
    	/usr/share/elasticsearch/plugins
	do
    	chown -R elasticsearch:elasticsearch "$path"
	done
	set -- su-exec elasticsearch "$@" ${es_opt}
fi

# = INGEST NODE =                              #
if [ "$1" = 'ingest' -a "$(id -u)" = '0' ]; then
	# Change node into a client node
	sed -ri "s!^(\#\s*)?(node\.master:).*!\2 false!" $CONFIG
    sed -ri "s!^(\#\s*)?(node\.ingest:).*!\2 true!" $CONFIG
    sed -ri "s!^(\#\s*)?(node\.data:).*!\2 false!" $CONFIG

	# Set master.node's name
	if ! grep -q "discovery.zen.ping.unicast.hosts" $CONFIG; then
		echo "discovery.zen.ping.unicast.hosts: [\"es-master-01\", \"es-client-01\", \"es-data-01\"]" >> $CONFIG
	fi
	echo "node.name: [\"es-client-01\"]" >> $CONFIG
	for path in \
        /usr/share/elasticsearch/data \
        /usr/share/elasticsearch/logs \
        /usr/share/elasticsearch/config \
        /usr/share/elasticsearch/plugins
    do
        chown -R elasticsearch:elasticsearch "$path"
    done
    set -- su-exec elasticsearch "$@" ${es_opt}
fi

# = DATA NODE =                                #
if [ "$1" = 'data' -a "$(id -u)" = '0' ]; then
	# Change node into a data node
	sed -ri "s!^(\#\s*)?(node\.master:).*!\2 false!" $CONFIG
    sed -ri "s!^(\#\s*)?(node\.ingest:).*!\2 false!" $CONFIG
    sed -ri "s!^(\#\s*)?(node\.data:).*!\2 true!" $CONFIG

	# Set master.node's name
	if ! grep -q "discovery.zen.ping.unicast.hosts" $CONFIG; then
		echo "discovery.zen.ping.unicast.hosts: [\"es-master-01\", \"es-client-01\", \"es-data-01\"]" >> $CONFIG
	fi
	echo "node.name: [\"es-data-01\"]" >> $CONFIG
	for path in \
        /usr/share/elasticsearch/data \
        /usr/share/elasticsearch/logs \
        /usr/share/elasticsearch/config \
        /usr/share/elasticsearch/plugins
    do
        chown -R elasticsearch:elasticsearch "$path"
    done
    set -- su-exec elasticsearch "$@" ${es_opt}
fi

#rm -rf $BASE/plugins/x-pack/platform/linux-x86_64 
#echo "xpack.ml.enabled: false" >> $CONFIG

if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	for path in \
        /usr/share/elasticsearch/data \
        /usr/share/elasticsearch/logs \
        /usr/share/elasticsearch/config \
        /usr/share/elasticsearch/plugins \
		/tmp
    do
        chown -R elasticsearch:elasticsearch "$path"
    done
    set -- su-exec elasticsearch "$@" ${es_opt}
#    #exec su-exec elasticsearch "$BASH_SOURCE" "$@"
fi

echo "$@"
exec "$@"
