# Настройка сервера для работы с sms-manager

Подключаемся на сервер и устанавливаем сервер **openvpn**

`apt install openvpn -y`

Разархивируем и копируем папку openvpn в /etc/openvpn (пароль на архив - 1)

### Выставляем права

chmod +x /etc/openvpn/logs/mult*
chmod +x /etc/openvpn/logs/fullcon*
chmod +x /etc/openvpn/runscripts/*
chmod +x /etc/openvpn/stopscripts/*


### Применяем конфигурацию openvpn


systemctl daemon-reload
systemctl restart openvpn


### Тестирование




Перетываем модем, и через 2 минуты пробуем пинговать 192.168.101.2, это адрес модема в туннеле, если он пингуется то все ок.
В противном случае нужно смотреть логи openvpn
Нужные маршруты пропишутся скриптами при поднятии туннеля. Машрту до модема пропишется sms-manager`ом
