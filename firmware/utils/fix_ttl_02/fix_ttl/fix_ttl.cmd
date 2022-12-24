<<<<<<< HEAD
@title Управление фиксацией TTL

@prompt $G 

adb connect 192.168.8.1:5555

@echo.
@echo Текущее значение (1 = 64):
adb shell cat /system/etc/fix_ttl

@echo.
@echo.
@echo Выберите действие:
@echo 1 - включить фиксацию TTL 64
@echo 2 - включить фиксацию TTL 128 (поддерживается не всеми прошивками)
@echo 3 - отключить фиксацию TTL
@echo 0 - выход
@set /P choice=": "

@if "%choice%" == "0" exit

@^
if not "%choice%" == "1" (
if not "%choice%" == "2" (
if not "%choice%" == "3" (
  echo.
  echo Неверный ввод
  goto quit
)))

adb shell mount -o remount,rw /system /system

@if not "%choice%" == "1" goto l1
adb shell "echo 1 > /system/etc/fix_ttl"
:l1
@if not "%choice%" == "2" goto l2
adb shell "echo 128 > /system/etc/fix_ttl"
:l2
@if not "%choice%" == "3" goto l3
adb shell "echo 0 > /system/etc/fix_ttl"
:l3

adb shell mount -o remount,ro /system /system

@echo.
@echo После нажатия клавиши устройство будет перезагружено
@pause > nul

adb reboot

:quit

@echo.
@echo Работа скрипта завершена. Нажмите любую клавишу
@pause > nul
=======
@title Управление фиксацией TTL

@prompt $G 

adb connect 192.168.8.1:5555

@echo.
@echo Текущее значение (1 = 64):
adb shell cat /system/etc/fix_ttl

@echo.
@echo.
@echo Выберите действие:
@echo 1 - включить фиксацию TTL 64
@echo 2 - включить фиксацию TTL 128 (поддерживается не всеми прошивками)
@echo 3 - отключить фиксацию TTL
@echo 0 - выход
@set /P choice=": "

@if "%choice%" == "0" exit

@^
if not "%choice%" == "1" (
if not "%choice%" == "2" (
if not "%choice%" == "3" (
  echo.
  echo Неверный ввод
  goto quit
)))

adb shell mount -o remount,rw /system /system

@if not "%choice%" == "1" goto l1
adb shell "echo 1 > /system/etc/fix_ttl"
:l1
@if not "%choice%" == "2" goto l2
adb shell "echo 128 > /system/etc/fix_ttl"
:l2
@if not "%choice%" == "3" goto l3
adb shell "echo 0 > /system/etc/fix_ttl"
:l3

adb shell mount -o remount,ro /system /system

@echo.
@echo После нажатия клавиши устройство будет перезагружено
@pause > nul

adb reboot

:quit

@echo.
@echo Работа скрипта завершена. Нажмите любую клавишу
@pause > nul
>>>>>>> 70ba0a4... repair repo
