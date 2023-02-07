#!/bin/bash

LOG="/var/log/sms.log"
MODEM=9
SEARCHSTRING1="9226710368"
SEARCHSTRING2="9253440222"
SEARCHSTRING3="996995242500"
TIME=`date "+%T"`
URL="https://api.mizerov.com/Log?msg"
SMSSTARTCOUNT="40000"

######   ESXI Server Variable #####


ESXISERVER="hertz2.svr.vc"
ESXIUSER="cloud"
ESXIPASS="5tgbfghG%"
ESXIVMID="7"         ########## Please run vim-cmd vmsvc/getallvms in esxi server and set vmid this


######   ESXI Server Variable #####


#alias BREAKLINE=`echo -en '\n'`


#clear
# break line
echo -en '\n'
echo "Скрипт запущен в $TIME"
echo -en '\n'
echo "Настраиваем маршрутизацию"


ip r a 192.168.8.1 dev tap$MODEM &>/dev/null
ip r c 192.168.8.1 dev tap$MODEM &>/dev/null

echo  "Получаем список смс и парсим их на предмет наличия вхождений $SEARCHSTRING1 $SEARCHSTRING2 и $SEARCHSTRING3"



CONTENT=`hlcli SmsList -boxType 1 -count 10 -page 1 -endpoint http://192.168.8.1 |  grep -E "$SEARCHSTRING1|$SEARCHSTRING2|$SEARCHSTRING3"`
PHONENUMBERS=`hlcli SmsList -boxType 1 -count 10 -page 1 -endpoint http://192.168.8.1 | grep "Phone" | cut -d ":" -f2 | cut -d '"' -f2 | grep "+" | sort -n | uniq`
SMSCOUNT=`hlcli SmsList -boxType 1 -count 10 -page 1 -endpoint http://192.168.8.1 | jq '.Count' -r`

# exit 0

smsclear (){

SMSENDCOUNT=$(($SMSSTARTCOUNT+$SMSCOUNT))
echo "Обнаружено $SMSCOUNT смс, вычищаем диапазон $SMSSTARTCOUNT-$SMSENDCOUNT"

SMSID=$SMSSTARTCOUNT
while [ $SMSID -lt $SMSENDCOUNT ]
do
	echo "Удаляем sms с  $SMSID"
	echo "Выполнится команда"
	hlcli SmsDelete -id  $SMSID -endpoint http://192.168.8.1
	SMSID=$(( $SMSID + 1 ))
done



}


numbers (){

for PHONENUMBER in $PHONENUMBERS
do
	echo "Выявлен номер $PHONENUMBER поэтому мы дергаем ссылку https://api.mizerov.com/Log?msg=$PHONENUMBER"
	curl "$URL=$PHONENUMBER"
	echo -en '\n'
	echo "Отправляем на ESXI сервер команду потушить виртуалку"
	result=`sshpass -p $ESXIPASS ssh -o StrictHostKeyChecking=no $ESXIUSER@$ESXISERVER "vim-cmd vmsvc/power.off $ESXIVMID"`
	echo $result
done
}


if [ -z "$CONTENT" ]; then
	echo "Мы не нашли смс с заданных номеров, завершаем работу скрипта"
else
	echo "Есть новые sms, дергаем ссылки"
	numbers # Вызываем функцию web запроса к массиву номеров
	echo "Теперь необходимо очистить список смс, вызываем функцию очистки"
	smsclear
fi

#sleep 100
