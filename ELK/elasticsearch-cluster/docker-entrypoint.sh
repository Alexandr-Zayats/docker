#!/bin/bash

set -e                                                                                    

#set -- elasticsearch "$@" ${ES_JAVA_OPTS}

# Add elasticsearch as command if needed
#if [ "${1:0:1}" = '-' ]; then
#  set -- elasticsearch "$@" ${ES_JAVA_OPTS} 
#fi

export BASE='/usr/share/elasticsearch'
CONFIG=${BASE}/config/elasticsearch.yml

sed -ri "s!^(\#\s*)?(cluster\.name:).*!\2 ${CLUSTER_NAME}!" $CONFIG
sed -ri "s!^(\#\s*)?(node\.name:).*!\2 ${HOSTNAME}!" $CONFIG
sed -ri "s!^(\#\s*)?(discovery\.zen\.ping\.unicast\.hosts:).*!\2 [\"elastic-master\", \"elasticsearch\", \"elastic-data\"]!" $CONFIG

# = MASTER NODE =                              #
if [ "${HOSTNAME}" = 'elastic-master' -a "$(id -u)" = '0' ]; then
	# Change node into a data master
	sed -ri "s!^(\#\s*)?(node\.master:).*!\2 true!" $CONFIG
  sed -ri "s!^(\#\s*)?(node\.ingest:).*!\2 false!" $CONFIG
  sed -ri "s!^(\#\s*)?(node\.data:).*!\2 false!" $CONFIG
fi

# = INGEST NODE =                              #
if [ "${HOSTNAME}" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	# Change node into a client node
	sed -ri "s!^(\#\s*)?(node\.master:).*!\2 false!" $CONFIG
  sed -ri "s!^(\#\s*)?(node\.ingest:).*!\2 true!" $CONFIG
  sed -ri "s!^(\#\s*)?(node\.data:).*!\2 false!" $CONFIG
fi

# = DATA NODE =                                #
if [ "${HOSTNAME}" = 'elastic-data' -a "$(id -u)" = '0' ]; then
	# Change node into a data node
	sed -ri "s!^(\#\s*)?(node\.master:).*!\2 false!" $CONFIG
  sed -ri "s!^(\#\s*)?(node\.ingest:).*!\2 false!" $CONFIG
  sed -ri "s!^(\#\s*)?(node\.data:).*!\2 true!" $CONFIG
fi

# Drop root privileges if we are running elasticsearch                                    
# allow the container to be started with `--user`                                         
#if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
# Change the ownership of user-mutable directories to elasticsearch               
for path in \
  /usr/share/elasticsearch/data \
  /usr/share/elasticsearch/logs \
  /usr/share/elasticsearch/config \
  /usr/share/elasticsearch/plugins \
  /tmp
do
  chown -R elasticsearch:elasticsearch "$path"
done

#set -- su-exec elasticsearch "$@"

#exec su-exec elasticsearch "$BASH_SOURCE" "$@"                                   
#fi

# As argument is not related to elasticsearch,                                            
# then assume that user wants to run his own process,                                     
# for example a `bash` shell to explore this image 
#echo "$@"
#exec "$@"
su-exec elasticsearch elasticsearch

