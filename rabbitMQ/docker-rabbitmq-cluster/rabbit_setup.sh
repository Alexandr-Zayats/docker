#!/bin/bash

#rabbitmqctl stop_app
#rabbitmqctl reset
#rabbitmqctl start_app

rabbitmqctl add_user ${RABBITMQ_DEFAULT_USER} ${RABBITMQ_DEFAULT_PASS}
rabbitmqctl set_user_tags ${RABBITMQ_DEFAULT_USER} administrator
rabbitmqctl set_permissions -p / ${RABBITMQ_DEFAULT_USER} ".*" ".*" ".*"

vHosts="Dev Stage Qa Int Prod"

for vhost in $vHosts; do
  rabbitmqctl add_vhost PA_Integration_Virtual_Host_${vhost}
  rabbitmqctl set_permissions -p PA_Integration_Virtual_Host_${vhost} ${RABBITMQ_DEFAULT_USER} ".*" ".*" ".*"

  rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Direct_exchange_ParsingResults type=direct -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Queue_ParsingResults -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin --vhost="PA_Integration_Virtual_Host_${vhost}" declare binding source="PA_Direct_exchange_ParsingResults" \
                destination_type="queue" destination="PA_Queue_ParsingResults" routing_key="key.parsing-results.all" -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}

  rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Direct_exchange_PriceListsProcessing type=direct -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Queue_PriceListsProcessing -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin --vhost="PA_Integration_Virtual_Host_${vhost}" declare binding source="PA_Direct_exchange_PriceListsProcessing" \
                destination_type="queue" destination="PA_Queue_PriceListsProcessing" routing_key="key.price-lists-processing.all" -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}

  rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Direct_exchange_MatchRequests type=direct -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Queue_MatchRequests -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin --vhost="PA_Integration_Virtual_Host_${vhost}" declare binding source="PA_Direct_exchange_MatchRequests" \
                destination_type="queue" destination="PA_Queue_MatchRequests" routing_key="key.match-requests.all" -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}

  rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Direct_exchange_MatchResponses type=direct -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Queue_MatchResponses -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin --vhost="PA_Integration_Virtual_Host_${vhost}" declare binding source="PA_Direct_exchange_MatchResponses" \
                destination_type="queue" destination="PA_Queue_MatchResponses" routing_key="key.match-responses.all" -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}

  rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Direct_exchange_WineCatalogRequests type=direct -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Queue_WineCatalogRequests -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin --vhost="PA_Integration_Virtual_Host_${vhost}" declare binding source="PA_Direct_exchange_WineCatalogRequests" \
                destination_type="queue" destination="PA_Queue_WineCatalogRequests" routing_key="key.wine-catalog-requests.all" -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}

  rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Direct_exchange_WineCatalogResponses type=direct -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_${vhost} name=PA_Queue_WineCatalogResponses -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
  rabbitmqadmin --vhost="PA_Integration_Virtual_Host_${vhost}" declare binding source="PA_Direct_exchange_WineCatalogResponses" \
                destination_type="queue" destination="PA_Queue_WineCatalogResponses" routing_key="key.wine-catalog-responses.all" -u ${RABBITMQ_DEFAULT_USER} -p ${RABBITMQ_DEFAULT_PASS}
done
