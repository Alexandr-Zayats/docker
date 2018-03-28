#!/bin/bash

rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl start_app

rabbitmqctl add_user integration_admin pa.@dmin2017.$$
rabbitmqctl set_user_tags integration_admin administrator
rabbitmqctl set_permissions -p / integration_admin ".*" ".*" ".*"

rabbitmqctl add_vhost PA_Integration_Virtual_Host_Stage
rabbitmqctl set_permissions -p PA_Integration_Virtual_Host_Stage integration_admin ".*" ".*" ".*"

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Stage name=PA_Direct_exchange_ParsingResults type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Stage name=PA_Queue_ParsingResults -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Stage" declare binding source="PA_Direct_exchange_ParsingResults" destination_type="queue" destination="PA_Queue_ParsingResults" routing_key="key.parsing-results.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Stage name=PA_Direct_exchange_PriceListsProcessing type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Stage name=PA_Queue_PriceListsProcessing -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Stage" declare binding source="PA_Direct_exchange_PriceListsProcessing" destination_type="queue" destination="PA_Queue_PriceListsProcessing" routing_key="key.price-lists-processing.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Stage name=PA_Direct_exchange_MatchRequests type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Stage name=PA_Queue_MatchRequests -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Stage" declare binding source="PA_Direct_exchange_MatchRequests" destination_type="queue" destination="PA_Queue_MatchRequests" routing_key="key.match-requests.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Stage name=PA_Direct_exchange_MatchResponses type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Stage name=PA_Queue_MatchResponses -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Stage" declare binding source="PA_Direct_exchange_MatchResponses" destination_type="queue" destination="PA_Queue_MatchResponses" routing_key="key.match-responses.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Stage name=PA_Direct_exchange_WineCatalogRequests type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Stage name=PA_Queue_WineCatalogRequests -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Stage" declare binding source="PA_Direct_exchange_WineCatalogRequests" destination_type="queue" destination="PA_Queue_WineCatalogRequests" routing_key="key.wine-catalog-requests.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Stage name=PA_Direct_exchange_WineCatalogResponses type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Stage name=PA_Queue_WineCatalogResponses -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Stage" declare binding source="PA_Direct_exchange_WineCatalogResponses" destination_type="queue" destination="PA_Queue_WineCatalogResponses" routing_key="key.wine-catalog-responses.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqctl add_vhost PA_Integration_Virtual_Host_Qa
rabbitmqctl set_permissions -p PA_Integration_Virtual_Host_Qa integration_admin ".*" ".*" ".*"

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Qa name=PA_Direct_exchange_ParsingResults type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Qa name=PA_Queue_ParsingResults -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Qa" declare binding source="PA_Direct_exchange_ParsingResults" destination_type="queue" destination="PA_Queue_ParsingResults" routing_key="key.parsing-results.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Qa name=PA_Direct_exchange_PriceListsProcessing type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Qa name=PA_Queue_PriceListsProcessing -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Qa" declare binding source="PA_Direct_exchange_PriceListsProcessing" destination_type="queue" destination="PA_Queue_PriceListsProcessing" routing_key="key.price-lists-processing.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Qa name=PA_Direct_exchange_MatchRequests type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Qa name=PA_Queue_MatchRequests -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Qa" declare binding source="PA_Direct_exchange_MatchRequests" destination_type="queue" destination="PA_Queue_MatchRequests" routing_key="key.match-requests.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Qa name=PA_Direct_exchange_MatchResponses type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Qa name=PA_Queue_MatchResponses -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Qa" declare binding source="PA_Direct_exchange_MatchResponses" destination_type="queue" destination="PA_Queue_MatchResponses" routing_key="key.match-responses.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Qa name=PA_Direct_exchange_WineCatalogRequests type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Qa name=PA_Queue_WineCatalogRequests -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Qa" declare binding source="PA_Direct_exchange_WineCatalogRequests" destination_type="queue" destination="PA_Queue_WineCatalogRequests" routing_key="key.wine-catalog-requests.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Qa name=PA_Direct_exchange_WineCatalogResponses type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Qa name=PA_Queue_WineCatalogResponses -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Qa" declare binding source="PA_Direct_exchange_WineCatalogResponses" destination_type="queue" destination="PA_Queue_WineCatalogResponses" routing_key="key.wine-catalog-responses.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqctl add_vhost PA_Integration_Virtual_Host_Dev
rabbitmqctl set_permissions -p PA_Integration_Virtual_Host_Dev integration_admin ".*" ".*" ".*"

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Dev name=PA_Direct_exchange_ParsingResults type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Dev name=PA_Queue_ParsingResults -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Dev" declare binding source="PA_Direct_exchange_ParsingResults" destination_type="queue" destination="PA_Queue_ParsingResults" routing_key="key.parsing-results.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Dev name=PA_Direct_exchange_PriceListsProcessing type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Dev name=PA_Queue_PriceListsProcessing -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Dev" declare binding source="PA_Direct_exchange_PriceListsProcessing" destination_type="queue" destination="PA_Queue_PriceListsProcessing" routing_key="key.price-lists-processing.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Dev name=PA_Direct_exchange_MatchRequests type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Dev name=PA_Queue_MatchRequests -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Dev" declare binding source="PA_Direct_exchange_MatchRequests" destination_type="queue" destination="PA_Queue_MatchRequests" routing_key="key.match-requests.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Dev name=PA_Direct_exchange_MatchResponses type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Dev name=PA_Queue_MatchResponses -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Dev" declare binding source="PA_Direct_exchange_MatchResponses" destination_type="queue" destination="PA_Queue_MatchResponses" routing_key="key.match-responses.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Dev name=PA_Direct_exchange_WineCatalogRequests type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Dev name=PA_Queue_WineCatalogRequests -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Dev" declare binding source="PA_Direct_exchange_WineCatalogRequests" destination_type="queue" destination="PA_Queue_WineCatalogRequests" routing_key="key.wine-catalog-requests.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Dev name=PA_Direct_exchange_WineCatalogResponses type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Dev name=PA_Queue_WineCatalogResponses -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Dev" declare binding source="PA_Direct_exchange_WineCatalogResponses" destination_type="queue" destination="PA_Queue_WineCatalogResponses" routing_key="key.wine-catalog-responses.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqctl add_vhost PA_Integration_Virtual_Host_Prod
rabbitmqctl set_permissions -p PA_Integration_Virtual_Host_Prod integration_admin ".*" ".*" ".*"

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Prod name=PA_Direct_exchange_ParsingResults type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Prod name=PA_Queue_ParsingResults -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Prod" declare binding source="PA_Direct_exchange_ParsingResults" destination_type="queue" destination="PA_Queue_ParsingResults" routing_key="key.parsing-results.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Prod name=PA_Direct_exchange_PriceListsProcessing type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Prod name=PA_Queue_PriceListsProcessing -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Prod" declare binding source="PA_Direct_exchange_PriceListsProcessing" destination_type="queue" destination="PA_Queue_PriceListsProcessing" routing_key="key.price-lists-processing.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Prod name=PA_Direct_exchange_MatchRequests type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Prod name=PA_Queue_MatchRequests -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Prod" declare binding source="PA_Direct_exchange_MatchRequests" destination_type="queue" destination="PA_Queue_MatchRequests" routing_key="key.match-requests.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Prod name=PA_Direct_exchange_MatchResponses type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Prod name=PA_Queue_MatchResponses -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Prod" declare binding source="PA_Direct_exchange_MatchResponses" destination_type="queue" destination="PA_Queue_MatchResponses" routing_key="key.match-responses.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Prod name=PA_Direct_exchange_WineCatalogRequests type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Prod name=PA_Queue_WineCatalogRequests -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Prod" declare binding source="PA_Direct_exchange_WineCatalogRequests" destination_type="queue" destination="PA_Queue_WineCatalogRequests" routing_key="key.wine-catalog-requests.all" -u integration_admin -p pa.@dmin2017.$$

rabbitmqadmin declare exchange --vhost=PA_Integration_Virtual_Host_Prod name=PA_Direct_exchange_WineCatalogResponses type=direct -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin declare queue --vhost=PA_Integration_Virtual_Host_Prod name=PA_Queue_WineCatalogResponses -u integration_admin -p pa.@dmin2017.$$
rabbitmqadmin --vhost="PA_Integration_Virtual_Host_Prod" declare binding source="PA_Direct_exchange_WineCatalogResponses" destination_type="queue" destination="PA_Queue_WineCatalogResponses" routing_key="key.wine-catalog-responses.all" -u integration_admin -p pa.@dmin2017.$$


