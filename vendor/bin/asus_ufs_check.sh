#!/vendor/bin/sh

sleep 2

oldval=`cat /sys/module/ufs_qcom/parameters/asus_ufs_uic_check`

if [ $oldval -eq 10000000 ] ; then
	oldval=1
	echo $oldval > /sys/module/ufs_qcom/parameters/asus_ufs_uic_check
fi

while [ true ]
do
	val=`cat /sys/module/ufs_qcom/parameters/asus_ufs_uic_check`

	if [ $val -eq 10000000 ] ; then
		val=1
		echo $val > /sys/module/ufs_qcom/parameters/asus_ufs_uic_check
	fi
if [ $val -ne $oldval ] ; then
	echo -n $val > /mnt/vendor/persist/asus_ufs_check.bin
	setprop vendor.asus.sys.asus_ufs_check $val
#	echo "[ufs] asus_ufs_check update ($val)" > /dev/kmsg
fi
#	echo "[ufs] asus_ufs_check ($val)" > /dev/kmsg
	oldval=$val
sleep 600

done
