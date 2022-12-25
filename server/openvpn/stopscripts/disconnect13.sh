#!/bin/bash
####Изменяемые переменные#####
#Номер модема
CMODEM=13
PORT=8093
LINE=192.168.113.1:$PORT
SQUID=/etc/squid/backend.conf
LOG=/etc/openvpn/logs/ccon.log

echo "MODEM $CMODEM DETACHED" >> $LOG

PROXYCHECK=$(ps -ef | grep "${CMODEM}modem_${PORT}.conf" | grep "squid-1" | awk '{print $2}') 

if [ -n "$PROXYCHECK" ] ; then

        echo "port $PORT available... clearing" >> $LOG
		kill -9 $PROXYCHECK
fi
echo "==============" >> $LOG
exit 0
