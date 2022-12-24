<<<<<<< HEAD
adb connect 192.168.8.1:5555
adb shell "mount -o remount,rw /system"
adb push flash_erase /
adb shell chmod 755 /flash_erase
adb shell /flash_erase /dev/mtd/mtd18 0 0
adb shell mount -o remount,ro /system /system
reboot
=======
adb connect 192.168.8.1:5555
adb shell "mount -o remount,rw /system"
adb push flash_erase /
adb shell chmod 755 /flash_erase
adb shell /flash_erase /dev/mtd/mtd18 0 0
adb shell mount -o remount,ro /system /system
reboot
>>>>>>> 70ba0a4... repair repo
