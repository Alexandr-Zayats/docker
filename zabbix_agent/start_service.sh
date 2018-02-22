docker service create --name zabbix \
--mode global -p 10050:10050 \
--mount type=volume,src='/var/run/docker.sock',dst='/var/run/docker.sock' \
--mount type=volume,src='/',dst='/rootfs' \
--mount type=volume,src='/etc/localtime',dst='/etc/localtime' \
-e ZABBIX_ENABLEREMOTECOMMANDS=1 \
-e ZABBIX_LOGREMOTECOMMANDS=1 \
-e ZABBIX_SERVER=194.105.144.242 \
-e ZABBIX_HOSTNAME=zabbix-agent \
-e ZABBIX_STARTAGENTS=1 \
registry.ciklum.net/zabbix/agent:1.1
