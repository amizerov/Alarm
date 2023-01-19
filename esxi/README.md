# Vmware Esxi - Управление виртуалками по ssh

## Включение ssh-сервера на Vmware Esxi

Для того чтобы включить доступ к серверу Vmware Esxi нужно воспользоваться по идее статьей в базе знаний vmware 

https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-DFA67697-232E-4F7D-860F-96C0819570A8.html
https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-DFA67697-232E-4F7D-860F-96C0819570A8.html
https://kb.vmware.com/s/article/8375637

### Но все гораздо проще, находясь в вебинтерфейсе нужно сделать клик как я показал стрелками на рисунке

![2023-01-19_02-36-50](https://user-images.githubusercontent.com/121182772/213319053-4644fc62-8caf-4a21-9a1e-e0f3a8f6781a.png)


## Подключение по ssh c linux

Для того чтобы запускать команды в пакетном (batch) режиме, т.е. не вводя каждый раз пароль можно пойти двумя путями:

1. Настроить авторизацию по ключам в ssh - Сложный путь, но если интересно то [тут](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-D262F36C-1EE4-45BF-BF7E-9A52BAA54D27.html#GUID-D262F36C-1EE4-45BF-BF7E-9A52BAA54D27) пишут как это сделать
2. Поставить пакет, который будет интерактивно вводить пароль за нас. Быстрый и НЕ очень секурный способ, используем его.

### Ставим пакеты в нашей Ubuntu:

`apt install sshpass -y`

### Устанавливаем переменные окружения

`ESXISERVER="hertz3.svr.vc"`

`ESXIUSER="cloud"`

`ESXIPASS="Kz5~8gnVNWoG9ChD"`

### Тестируем подключение

`sshpass -p $ESXIPASS ssh -o StrictHostKeyChecking=no $ESXIUSER@$ESXISERVER "cat /etc/hosts"`

Если все ок, то мы получим что-то вроде этого

![2023-01-19_02-58-00](https://user-images.githubusercontent.com/121182772/213323693-e19ec0c0-793b-43c8-87cf-f62b5a130e49.png)

### Получаем список виртуалок

Управление виртуалками в консоли Vmware Esxi осуществляется с помощью утилиты vim-cmd, подробно это описано в [Базе знаний](https://kb.vmware.com/s/article/1004340)

Получаем список виртуалок (сначала в консоли Esxi)





