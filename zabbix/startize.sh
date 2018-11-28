#!/bin/bash
if [ -d /usr/local/nginx12/html/zabbixweb ]
  then
   # Access control Settings
    chown -R nginx.nginx /usr/local/nginx12/html/zabbixweb
    groupadd zabbix
    useradd -g zabbix -s /sbin/nologin -M zabbix
    chown -R zabbix.zabbix /usr/local/zabbix
  else
   exit 12
fi
pid=$(ps -elf|grep "nginx: master process"|grep -v grep|awk '{print $4}')
if [ "$pid" = "" ]
      then
         /usr/local/php71/sbin/php-fpm
         /usr/local/zabbix/sbin/zabbix_server
         /usr/local/zabbix/sbin/zabbix_agentd
      else
        exit 12
fi
