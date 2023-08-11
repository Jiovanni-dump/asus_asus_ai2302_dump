#!/vendor/bin/sh

BATTERY=`cat /sys/devices/virtual/extcon-asus/battery/name`
setprop vendor.battery.version.driver "$BATTERY"

WLCVERSION=`cat /sys/class/asuslib/wlc_nu1628_fw_update`

setprop vendor.wlc.support.driver 1
