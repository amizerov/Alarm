<<<<<<< HEAD
adb connect 192.168.8.1:5555
adb push flash_erase /
adb shell chmod 777 /flash_erase
adb shell umount /data
adb shell /flash_erase /dev/mtd/mtd16 0 0
adb shell reboot
@echo;
@pause
=======
adb connect 192.168.8.1:5555
adb push flash_erase /
adb shell chmod 777 /flash_erase
adb shell umount /data
adb shell /flash_erase /dev/mtd/mtd16 0 0
adb shell reboot
@echo;
@pause
>>>>>>> 70ba0a4... repair repo
