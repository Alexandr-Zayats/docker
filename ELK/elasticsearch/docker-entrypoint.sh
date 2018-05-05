#!/bin/bash

set -e                                                                                    

export BASE='/usr/share/elasticsearch'
CONFIG=${BASE}/config/elasticsearch.yml

#sed -ri "s!^(\#\s*)?(cluster\.name:).*!\2 ${CLUSTER_NAME}!" $CONFIG

for path in \
  /usr/share/elasticsearch/data \
  /usr/share/elasticsearch/logs \
  /usr/share/elasticsearch/config \
  /usr/share/elasticsearch/plugins \
  /tmp
do
  chown -R elasticsearch:elasticsearch "$path"
done

su-exec elasticsearch elasticsearch

