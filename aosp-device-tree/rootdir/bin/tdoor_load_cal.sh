#!/vendor/bin/sh

if [ -e /vendor/factory/mcu_close_cal ] ; then
mcu_close_cal=`cat /vendor/factory/mcu_close_cal`
fi

if [ -e /vendor/factory/mcu_open_cal ] ; then
mcu_open_cal=`cat /vendor/factory/mcu_open_cal`
fi

echo "[MSP430][Load_Cal_Data] Apply Cal data, mcu_open_cal = $mcu_open_cal, mcu_close_cal = $mcu_close_cal" > /dev/kmsg
echo "$mcu_open_cal $mcu_close_cal" > /proc/asus_motor/rog6_k

if [ -e /vendor/factory/mcu_half_cal ] ; then
	mcu_half_cal=`cat /vendor/factory/mcu_half_cal`
	halfz=$(echo $mcu_half_cal | cut -d" " -f 1)
	#echo "halfz=$halfz"

	echo "[MSP430][Load_Cal_Data] mcu_half_cal = $mcu_half_cal" > /dev/kmsg

	#Z>=0, or Z<0
	if [ $halfz -ge 0 ]
	then
		#Z>0  initial RAW_STR1=3472
		let "RAW_STR1_BOPZ = $halfz + 64"
		let "RAW_STR1_BRPZ = $halfz "

		let "BOPZ_15_8 = $RAW_STR1_BOPZ / 256"
		let "BOPZ_7_0 = $RAW_STR1_BOPZ % 256"

		let "BRPZ_15_8 = $RAW_STR1_BRPZ / 256"
		let "BRPZ_7_0 = $RAW_STR1_BRPZ % 256"
	else
		#Z<-64  initial RAW_STR1=-3472
		let "RAW_STR1_BOPZ = $halfz + 65536"
		let "RAW_STR1_BRPZ = $halfz -64 + 65536"

		let "BOPZ_15_8 = $RAW_STR1_BOPZ / 256"
		let "BOPZ_7_0 = $RAW_STR1_BOPZ % 256"

		let "BRPZ_15_8 = $RAW_STR1_BRPZ / 256"
		let "BRPZ_7_0 = $RAW_STR1_BRPZ % 256"

	fi

	#echo "RAW_STR1_BOPZ=$RAW_STR1_BOPZ"
	#echo "RAW_STR1_BRPZ=$RAW_STR1_BRPZ"

	#write Z-thershold to AK9973

	echo "[MSP430][Load_Cal_Data] BOPZ = ${BOPZ_15_8}${BOPZ_7_0}, BRPZ = ${BRPZ_15_8}${BRPZ_7_0}" > /dev/kmsg
	echo "101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ${BOPZ_15_8} ${BOPZ_7_0} ${BRPZ_15_8} ${BRPZ_7_0} 0 0 0 0" > /proc/asus_motor/motor_akm
else
	echo "[MSP430][Load_Cal_Data] echo default value." > /dev/kmsg
	echo "101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 242 112 242 48 0 0 0 0" > /proc/asus_motor/motor_akm
fi
