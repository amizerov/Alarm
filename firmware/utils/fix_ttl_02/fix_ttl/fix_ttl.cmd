<<<<<<< HEAD
@title ��ࠢ����� 䨪�樥� TTL

@prompt $G 

adb connect 192.168.8.1:5555

@echo.
@echo ����饥 ���祭�� (1 = 64):
adb shell cat /system/etc/fix_ttl

@echo.
@echo.
@echo �롥�� ����⢨�:
@echo 1 - ������� 䨪��� TTL 64
@echo 2 - ������� 䨪��� TTL 128 (�����ন������ �� �ᥬ� ��訢����)
@echo 3 - �⪫���� 䨪��� TTL
@echo 0 - ��室
@set /P choice=": "

@if "%choice%" == "0" exit

@^
if not "%choice%" == "1" (
if not "%choice%" == "2" (
if not "%choice%" == "3" (
  echo.
  echo ������ ����
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
@echo ��᫥ ������ ������ ���ன�⢮ �㤥� ��१���㦥��
@pause > nul

adb reboot

:quit

@echo.
@echo ����� �ਯ� �����襭�. ������ ���� �������
@pause > nul
=======
@title ��ࠢ����� 䨪�樥� TTL

@prompt $G 

adb connect 192.168.8.1:5555

@echo.
@echo ����饥 ���祭�� (1 = 64):
adb shell cat /system/etc/fix_ttl

@echo.
@echo.
@echo �롥�� ����⢨�:
@echo 1 - ������� 䨪��� TTL 64
@echo 2 - ������� 䨪��� TTL 128 (�����ন������ �� �ᥬ� ��訢����)
@echo 3 - �⪫���� 䨪��� TTL
@echo 0 - ��室
@set /P choice=": "

@if "%choice%" == "0" exit

@^
if not "%choice%" == "1" (
if not "%choice%" == "2" (
if not "%choice%" == "3" (
  echo.
  echo ������ ����
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
@echo ��᫥ ������ ������ ���ன�⢮ �㤥� ��१���㦥��
@pause > nul

adb reboot

:quit

@echo.
@echo ����� �ਯ� �����襭�. ������ ���� �������
@pause > nul
>>>>>>> 70ba0a4... repair repo
