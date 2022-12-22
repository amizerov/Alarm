#!/bin/bash

LOG="/var/log/sms.log"
MODEM=9
SEARCHSTRING1="9226710368"
SEARCHSTRING2="9253440222"
SEARCHSTRING3="996995242500"
TIME=`date "+%T"`
URL="https://api.mizerov.com/Log?msg"
SMSSTARTCOUNT="40000"

#alias BREAKLINE='echo -en "\n" | te'


#clear
# break line
echo -en "\n"
echo "Скрипт запущен в $TIME"
# break line
echo -en "\n"
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

exit 0



hlcli SmsDelete -id 40009 -endpoint http://192.168.8.1
}


numbers (){

for PHONENUMBER in $PHONENUMBERS
do
	echo "Выявлен номер $PHONENUMBER поэтому мы дергаем ссылку https://api.mizerov.com/Log?msg=$PHONENUMBER"
	curl "$URL=$PHONENUMBER" &> /dev/null
done
}


if [ -z "$CONTENT" ]; then
	echo "Мы не нашли смс с заданных номеров, завершаем работу скрипта"
else
	echo "Есть новые sms"
	echo "Как нас попросил Андрей Вадимович дергаем ссылки"
	numbers # Вызываем функцию web запроса к массиву номеров
	echo "Теперь необходимо очистить список смс, вызываем функцию очистки"
	smsclear
fi

#sleep 100
