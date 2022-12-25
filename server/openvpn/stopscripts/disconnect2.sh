#!/bin/bash
####Изменяемые переменные#####
#Номер модема
#DISNOTIFY=disconnect0$CMODEM.sh
CMODEM=2
PORT=808$CMODEM
LINE=192.168.102.1:$PORT
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























####################################

#logger "modem$CMODEM Disconnected"
#echo "OK modem$CMODEM is Disconnected" >> $LOG
#
#wget -o /dev/null -O /home/router/up1m_sendstatus http://136.243.84.194/proxy/unactivate/$PORT/
#
#################################
##Прибиваем старый SSH          
#################################
#
#SSHD=$(ps -ef | grep $PORT | grep -v grep | awk {'print $2'})
#
#if [ -z "$SSHD" ] ; then
#echo "OK SSHD PID is out message from $DISNOTIFY $(date) " >> $LOG
#else
#for D in `ps -ef | grep $PORT | grep -v grep | awk {'print $2'}`; do kill -9 $D; done
#echo "OK SSHD Manually killed message from $DISNOTIFY $(date) " >> $LOG
#fi

exit 0
