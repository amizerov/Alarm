#!/bin/bash
CMODEM=3
PORT=808$CMODEM
IPV=192.168.10${CMODEM}
SQUID=/etc/squid/backend/${CMODEM}modem_${PORT}.conf
LOG=/etc/openvpn/logs/ccon.log
LINE=192.168.103.1:8083

function backend_start()
{
/usr/sbin/squid3 -FYC -f $SQUID
}

#route table check



echo "================$(date)========================" >> $LOG

echo "MODEM $CMODEM CONNECTED" >> $LOG

TABLE=$(ip route show table $CMODEM)


if [ -z "$TABLE" ] ; then

ip route add $IPV.0/24 dev tap$CMODEM table $CMODEM

echo "OK TABLE $CMODEM CREATED" >> $LOG

ip route add default via $IPV.2 table $CMODEM


echo "OK TABLE $CMODEM UPDATED" >> $LOG

else

echo "OK TABLE $CMODEM ALREADY ADDED" >> $LOG

fi

RULE=$(ip rule show | grep $IPV | awk {'print $5'})

if [ -z "$RULE" ] ; then

ip rule add from $IPV.1 table $CMODEM

echo "OK RULE $CMODEM ADDED" >> $LOG

else

echo "OK RULE $CMODEM ALREADY ADDED" >> $LOG
#echo "========================================" >> $LOG

#exit 0

fi

PROXYCHECK=$(netstat -tulpn | grep -o $LINE)

if [ -z "$PROXYCHECK" ] ; then

#sed "/#http_port *\($LINE\)/s/^#//" -i $SQUID

#backend_start

echo "OK PROXY ON $PORT STARTED" >> $LOG

else

echo "OK PROXY ON $PORT ALREADY STARTED" >> $LOG

echo "===================$(date)=====================" >> $LOG

fi

exit 0
