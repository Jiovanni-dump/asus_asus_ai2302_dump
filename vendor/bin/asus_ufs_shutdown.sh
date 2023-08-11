#!/vendor/bin/sh

echo 1 > /sys/devices/platform/soc/1d84000.ufshc/qcom/asus_ufs_lock

val=`cat /sys/module/ufs_qcom/parameters/asus_ufs_uic_check`

if [ $val -eq 10000000 ] ; then
	val=1
fi

echo -n $val > /mnt/vendor/persist/asus_ufs_check.bin
echo "[ufs] asus_ufs_shutdown ($val)" > /dev/kmsg
