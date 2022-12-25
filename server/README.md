


### Необходимо установить openvpn в стандартном его варианте:

apt install openvpn -y


### Копируем папку openvpn репы в /etc/openvpn

### Выставляем права

chmod +x /etc/openvpn/logs/mult*
chmod +x /etc/openvpn/logs/fullcon*
chmod +x /etc/openvpn/runscripts/*
chmod +x /etc/openvpn/stopscripts/*


### Применяем конфигурацию


systemctl daemon-reload
systemctl restart openvpn
