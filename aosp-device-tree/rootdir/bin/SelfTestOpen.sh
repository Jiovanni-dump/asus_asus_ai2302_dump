#!/vendor/bin/sh

echo 1 120 0 0 0 0 0 250 0 0 0 0 0 0 0 0 0 0 0 254 > /proc/asus_motor/motor_param
sleep 0.5
echo 102 > /proc/asus_motor/motor_akm
sleep 0.1
# save close raw z/y/x
RAW_STR1=`cat /proc/asus_motor/motor_akm_raw_z`
RAW_STR2=`cat /proc/asus_motor/motor_akm_raw_y`
RAW_STR3=`cat /proc/asus_motor/motor_akm_raw_x`

INT_COUNT_BEGIN=`cat /proc/asus_motor/motor_int`

TOTAL_STEP=320
echo 0 120 0 0 0 0 0 80 0 0 0 0 0 0 0 0 0 0 0 254 > /proc/asus_motor/motor_param
sleep 0.5
echo 102 > /proc/asus_motor/motor_akm
sleep 0.1
PRE_Z=`cat /proc/asus_motor/motor_akm_raw_z`
PRE_X=`cat /proc/asus_motor/motor_akm_raw_x`
#echo "PRE_Z=$PRE_Z PRE_X=$PRE_X"

i=1;
while [ $i -le 20 ];
do
	echo 0 120 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 254 > /proc/asus_motor/motor_param
	sleep 0.5
	echo 102 > /proc/asus_motor/motor_akm
	sleep 0.1
	Z=`cat /proc/asus_motor/motor_akm_raw_z`
	X=`cat /proc/asus_motor/motor_akm_raw_x`
	#echo "Z=$Z X=$X"
	let "DELTA_Z = $Z - $PRE_Z"
	let "DELTA_X = $X - $PRE_X"
	#echo "DELTA_Z=$DELTA_Z DELTA_X=$DELTA_X"
	let "TEST = ($DELTA_Z*$DELTA_Z) + ($DELTA_X*$DELTA_X)"
	#echo "TEST=$TEST"
	if [ $TEST -lt 10000 ]
	then
		i=$(($i + 20)) #terminate while loop
	else
		i=$(($i + 1))
		TOTAL_STEP=$((TOTAL_STEP+80))
		PRE_Z=${Z}
		PRE_X=${X}
	fi
	#echo "TOTAL_STEP=$TOTAL_STEP"
done;
INT_COUNT_AFTER=`cat /proc/asus_motor/motor_int`
#echo "INT_COUNT_AFTER=$INT_COUNT_AFTER INT_COUNT_BEGIN=$INT_COUNT_BEGIN"
let "INT_COUNT_VARY= $INT_COUNT_AFTER - $INT_COUNT_BEGIN"

#interrupt trigger 1 times
#if [ $INT_COUNT_VARY -eq 1 ]
#then
	if [ $TOTAL_STEP -ge 700 ] && [ $TOTAL_STEP -lt 1049 ];
	then
		#Vaild Pass, Write to factory.
		echo "${RAW_STR1} ${RAW_STR2} ${RAW_STR3}" > /vendor/factory/mcu_close_cal
		echo "65536 65536 65536 ${RAW_STR1} ${RAW_STR2} ${RAW_STR3}" > /proc/asus_motor/rog6_k
	else
		TOTAL_STEP=$((TOTAL_STEP/10))
	fi
#else
#	TOTAL_STEP=0
#fi

echo $TOTAL_STEP
