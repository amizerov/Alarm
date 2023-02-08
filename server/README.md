# Настройка сервера для работы с sms-manager

Подключаемся на сервер и устанавливаем сервер **openvpn** а также некоторые необходимые нам пакеты

`apt install openvpn p7zip-full zip dialog nano git screen jq golang -y`


Разархивируем и копируем папку openvpn в /etc/openvpn (пароль на архив - 1)

### Выставляем права

`chmod +x /etc/openvpn/logs/fullcon/*`

`chmod +x /etc/openvpn/runscripts/*`

`chmod +x /etc/openvpn/stopscripts/*`


### Применяем конфигурацию openvpn


`systemctl daemon-reload`

`systemctl restart openvpn`

### Установка hilink

`cd /tmp ; git clone https://github.com/kenshaw/hilink.git ; cd hilink/`
`go get -u github.com/kenshaw/hilink/cmd/hlcli`


### Установка sms-manager

`mkdir /opt/Alarm ; cd /tmp ; git clone https://github.com/amizerov/Alarm.git`
`cd Alarm/ ; cp sms-* /opt/Alarm/ ; cd /opt/Alarm/`

Здесь мы должны запустить фоновый процесс sms-manager, для этого запускаем отдельную сессию

`screen`

В этой сессии запускаем фоновый процесс

`bash sms-diver.sh | logger -t sms-manager`

Теперь выходим из этой сесии нажав Cntrl + A и Cntrl + D. Вернуться в эту сессию мы всегда можем запустив 

`screen -r`

Посмотреть лог скрипта можно, отфильтровав его в сислоге

```
tail -f /var/log/syslog | grep sms-manager
```


### Тестирование

Выполняем команду **ifconfig** в списке интерфейсов мы должны увидеть новый интерфейс **tap1**


![2022-12-28_03-49-47](https://user-images.githubusercontent.com/121182772/209740916-ddfc1749-27b4-4650-b9ea-c86e6e9dcb69.png)


* Перетываем модем, и через 2 минуты пробуем пинговать 192.168.101.2, это адрес модема в туннеле, если он пингуется то все ок.
* В противном случае нужно смотреть логи openvpn
* Нужные маршруты пропишутся скриптами при поднятии туннеля.
* Машртут до модема пропишется sms-manager`ом
* Посмотреть лог sms-manager мы всегда можем подключившись к фоновому процессу выполнив команды

`screen -r`

```
tail -f /var/log/syslog | grep sms-manager
```



