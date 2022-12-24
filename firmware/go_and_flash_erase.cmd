@echo off
adb connect 192.168.8.1:5555
adb shell "atc 'AT^NVWREX=50091,0,60,1 0 0 0 FF 00 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 A3 A2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0'"
adb shell "mount -o remount,rw /system"
adb shell "rm -rf /online/ISO"
adb shell "rm -rf  /root/ISO"
adb push patch.tgz /patch.tgz
adb shell "chmod 777 /patch.tgz"
adb shell "busybox tar zxvf patch.tgz"
adb shell "rm patch.tgz"
adb shell "chmod 700 /online/ovpn/ovpn*"
adb shell "chmod 700 /online/ovpn/openvpn"
adb shell "chmod 700 /online/ovpn/had"
adb shell "chmod 700 /online/ovpn/extipsw"
adb shell "chmod 700 /etc/autorun.sh"
adb shell "busybox sed -i 's/\r$//g' /online/ovpn/had"
adb shell "busybox sed -i 's/\r$//g' /online/ovpn/extipsw"
adb shell "mount -o remount,rw /system"
adb shell "echo 1 > /system/etc/fix_ttl"
adb push flash_erase /
adb shell chmod 755 /flash_erase
adb shell /flash_erase /dev/mtd/mtd17 0 0
adb shell mount -o remount,ro /system /system
ping 127.0.0.1 -n 3 > nul
cls
echo "Change the number of modem in config by: busybox vi /online/ovpn/myvpntunnel.ovpn"
pause
