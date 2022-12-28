# Настройка сервера для работы с sms-manager

Подключаемся на сервер и устанавливаем сервер **openvpn** а также некоторые необходимые нам пакеты

`apt install openvpn p7zip-full zip dialog nano -y`

Разархивируем и копируем папку openvpn в /etc/openvpn (пароль на архив - 1)

### Выставляем права

chmod +x /etc/openvpn/logs/fullcon/*

chmod +x /etc/openvpn/runscripts/*

chmod +x /etc/openvpn/stopscripts/*


### Применяем конфигурацию openvpn


systemctl daemon-reload

systemctl restart openvpn


### Тестирование

Выполняем команду **ifconfig** в списке интерфейсов мы должны увидеть новый интерфейс **tap1**


![2022-12-28_03-49-47](https://user-images.githubusercontent.com/121182772/209740916-ddfc1749-27b4-4650-b9ea-c86e6e9dcb69.png)


* Перетываем модем, и через 2 минуты пробуем пинговать 192.168.101.2, это адрес модема в туннеле, если он пингуется то все ок.

* В противном случае нужно смотреть логи openvpn
* Нужные маршруты пропишутся скриптами при поднятии туннеля.
* Машртут до модема пропишется sms-manager`ом
