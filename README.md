## Sms-Manager  управление виртуалками в Vmware Esxi через смс

> Sms-Manager представляет собой набор скриптов, объединенных в демон непрерывно работающий в Linux, управление которым происходит с помощью смс.
> В качестве источника смс я использую типичный для таких сценариев [Huawei e3372h](https://market.yandex.ru/product--4g-lte-modem-huawei-e3372h-320/667862013?cpa=1)
 
 
 ## Архитектура и прицнип действия

> Смс с мобильного телефона поступают на симкарту модема. Модем с помощью openvpn туннеля связан с сервером, через этот туннель, с помощью api модема смс менеджер производит опрос модема на предмет новых смс. При поступлении смс она проверяется на соответствие условиям - номеру/содержанию и если она удовлетворяет условиям - на ESXI отправляется команда о перезагрузке\остановке виртуальной машины. 

> На рисунке изображены связи участников схемы между собой

![sms-manager](https://user-images.githubusercontent.com/121182772/209685197-a58e2dcf-62d0-435f-819e-dd339cfa5588.png)

