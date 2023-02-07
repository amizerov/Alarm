#!/bin/bash

SOURCE=/opt/Alarm
CMD=sms-manager.sh
NOHUP=$SOURCE/nohup.out
SLP=30

while true
        do
		echo "Diver exec sms-manager" | tee -a /var/log/sms.log
                /bin/bash $SOURCE/$CMD  | tee -a /var/log/sms.log
                sleep $SLP
        done



