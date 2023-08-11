#!/vendor/bin/sh

val=0

if [ -e /mnt/vendor/persist/asus_ufs_check.bin ] ; then
	val=`cat /mnt/vendor/persist/asus_ufs_check.bin`
else
	echo "[ufs]asus_ufs_check.bin is not exist" > /dev/kmsg
fi

echo "[ufs]asus_ufs_init ($val)" > /dev/kmsg

#if [ $val -eq 0 ] ; then
	echo 0 > /sys/devices/platform/soc/1d84000.ufshc/qcom/asus_ufs_lock
#else
#	echo 1 > /sys/devices/platform/soc/1d84000.ufshc/qcom/asus_ufs_lock
	echo $val > sys/module/ufs_qcom/parameters/asus_ufs_uic_check
#fi
