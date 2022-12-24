adb connect 192.168.8.1:5555
adb push flash_erase /
adb shell chmod 777 /flash_erase
adb shell umount /data
adb shell /flash_erase /dev/mtd/mtd18 0 0
adb shell reboot
@echo off
