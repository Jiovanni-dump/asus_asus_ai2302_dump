#!/system/bin/sh
PATH=/system/bin/:$PATH

export_check_key() {
	#am start -S -n com.asus.atd.deviceproperty/.MainActivity -e getinfo "AttesetationKey"
	am start-foreground-service -n com.asus.key_status/.A_KEY
	#am startservice -n com.asus.key_status/.A_KEY
	sleep 1

	akey_status=`cat /sdcard/Documents/ATTK`
	echo "[AKEY]: check ${akey_status}" > /proc/asusevtlog
	if [ "${akey_status}" = "TRUE" ]; then
		setprop vendor.asus.akey.status 1
	elif [ "${akey_status}" = "FALSE" ]; then
		setprop vendor.asus.akey.status 0
	else
		setprop vendor.asus.akey.status -1
	fi
        am force-stop com.asus.key_status
        echo "[AKEY]: check done!" > /proc/asusevtlog
	#rm -f /sdcard/Documents/ATTK
}

echo "[AKEY]: boot complete" > /proc/asusevtlog
sleep 10m
echo "[AKEY]: start" > /proc/asusevtlog

count="1"
while [ 1 ]
do
echo $count
count=$(($count+1))
export_check_key
sleep 12h
done
