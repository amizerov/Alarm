#!/bin/bash

LOG="/var/log/sms.log"
MODEM=9
TIME=`date "+%T"`
URL="https://api.mizerov.com/Alarm?number"
SMSSTARTCOUNT="40000"

######   ESXI Server Variable #####


ESXISERVER="hertz2.local"
ESXIUSER="cloud"
ESXIPASS="5tgbfghG%45tgih45gohe"
ESXIVMID="7"         ########## Please run vim-cmd vmsvc/getallvms in esxi server and set vmid this


######   ESXI Server Variable #####

#clear
# break line
echo -en '\n'
echo "Скрипт запущен в $TIME"
echo -en '\n'
echo "Настраиваем маршрутизацию"


ip r a 192.168.8.1 dev tap$MODEM &>/dev/null
ip r c 192.168.8.1 dev tap$MODEM &>/dev/null

echo  "Получаем список смс"

CONTENT=`hlcli SmsList -boxType 1 -count 10 -page 1 -endpoint http://192.168.8.1`
PHONENUMBERS=`hlcli SmsList -boxType 1 -count 10 -page 1 -endpoint http://192.168.8.1 | grep "Phone" | cut -d ":" -f2 | cut -d '"' -f2 | grep "+" | sort -n | uniq`
SMSCOUNT=`hlcli SmsList -boxType 1 -count 10 -page 1 -endpoint http://192.168.8.1 | jq '.Count' -r`
SMSCONTENT=`hlcli SmsList -boxType 1 -count 10 -page 1 -endpoint http://192.168.8.1 | grep "Content" | cut -d ":" -f2 | cut -d '"' -f2 | sort -n | uniq`

smsclear (){

SMSENDCOUNT=$(($SMSSTARTCOUNT+$SMSCOUNT))
echo "Обнаружено $SMSCOUNT смс, вычищаем диапазон $SMSSTARTCOUNT-$SMSENDCOUNT"

SMSID=$SMSSTARTCOUNT
while [ $SMSID -lt $SMSENDCOUNT ]
do
	echo "Удаляем sms с  $SMSID"
	hlcli SmsDelete -id  $SMSID -endpoint http://192.168.8.1
	SMSID=$(( $SMSID + 1 ))
done

}


numbers (){

for PHONENUMBER in $PHONENUMBERS
do
	echo "Отправляем на сервер запрос  дергаем ссылку $URL=$PHONENUMBER" #&smscontent=$SMSCONTENT"
	curl "$URL=$PHONENUMBER" -s > /dev/null
	echo -en '\n'
	#echo "Отправляем на ESXI сервер команду потушить виртуалку"
	#result=`sshpass -p $ESXIPASS ssh -o StrictHostKeyChecking=no $ESXIUSER@$ESXISERVER "vim-cmd vmsvc/power.off $ESXIVMID"`
	#echo $result
done
}



if [ $SMSCOUNT -gt 0 ]; then

	echo "Есть новые sms, дергаем ссылки"
        numbers # Вызываем функцию web запроса к массиву номеров
        echo "Теперь необходимо очистить список смс, вызываем функцию очистки"
        smsclear

else
	echo "Мы не нашли смс с заданных номеров, завершаем работу скрипта"
fi


