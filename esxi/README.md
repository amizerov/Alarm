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

`ESXISERVER="hertz3.local"`

`ESXIUSER="cloud"`

`ESXIPASS="5tgbfghG%"`

### Тестируем подключение

`sshpass -p $ESXIPASS ssh -o StrictHostKeyChecking=no $ESXIUSER@$ESXISERVER "cat /etc/hosts"`

Если все ок, то мы получим что-то вроде этого

![2023-01-19_02-58-00](https://user-images.githubusercontent.com/121182772/213323693-e19ec0c0-793b-43c8-87cf-f62b5a130e49.png)

### Управление виртуалками в консоли Vmware Esxi

Управление виртуалками в консоли Vmware Esxi осуществляется с помощью утилиты vim-cmd, подробно это описано в [Базе знаний](https://kb.vmware.com/s/article/1004340)

Получаем список виртуалок (сначала в консоли Esxi)


![2023-01-19_03-04-22](https://user-images.githubusercontent.com/121182772/213324652-a7e09a7b-9159-4232-b81f-ce2ffa0b4d8c.png)

Как видно на скрине у каждой виртуалки есть свой ID, оперируя им мы можем запросить/изменить состояние любой из машин, например для виртуалки example-for-test-http-api-with-bash с id это выглядит так:

`vim-cmd vmsvc/power.getstate 90`
`vim-cmd vmsvc/power.on 90`


![2023-01-19_03-09-07](https://user-images.githubusercontent.com/121182772/213325125-6ee61d49-0c41-47e4-a339-267252a4d61e.png)

На примере выше мы запросили состояние виртуалки с id 90, включили ее, и опять запросили состояние

### Управление виртуалками по ssh

Скомбинируя описанные ранее команды получаем состояние виртуалки с id 90 по ssh

`sshpass -p $ESXIPASS ssh -o StrictHostKeyChecking=no $ESXIUSER@$ESXISERVER "vim-cmd vmsvc/power.getstate 90"`

![2023-01-19_03-15-41](https://user-images.githubusercontent.com/121182772/213325817-09e37f19-a4a6-4cc0-874d-7218d74465af.png)


### Управление по ssh из кода

Для того чтобы использовать описанные выше способы в разработке нужно поднять сессию ssh средствами того языка, на котором мы пишем и выполнять команды как локальные на сервере Esxi, а вывод команд парсить. 

Вот фрагмент кода на bash, где я проверяю состояние виртуалки

```bash
#!/bin/bash

ESXISERVER="hertz3.local"
ESXIUSER="cloud"
ESXIPASS="5tgbfghG%"

result=`sshpass -p $ESXIPASS ssh -o StrictHostKeyChecking=no $ESXIUSER@$ESXISERVER "vim-cmd vmsvc/power.getstate 90" | grep Powered`
echo $result
```

Переменная $result теперь может иметь строковое значение Powered off или Powered on, любое другое мы должны трактовать как ошибку. 




