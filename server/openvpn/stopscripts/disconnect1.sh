#!/bin/bash
####Изменяемые переменные#####
#Номер модема
#DISNOTIFY=disconnect0$CMODEM.sh
CMODEM=1
PORT=808$CMODEM
LINE=192.168.101.1:$PORT
SQUID=/etc/squid/backend/${CMODEM}modem${PORT}.conf
LOG=/etc/openvpn/logs/ccon.log

echo "MODEM $CMODEM DETACHED" >> $LOG

PROXYCHECK=$(ps -ef | grep "${CMODEM}modem_${PORT}.conf" | grep "squid-1" | awk '{print $2}') 

if [ -n "$PROXYCHECK" ] ; then

        echo "port $PORT available... clearing" >> $LOG
		kill -9 $PROXYCHECK
fi
echo "==============" >> $LOG
exit 0


