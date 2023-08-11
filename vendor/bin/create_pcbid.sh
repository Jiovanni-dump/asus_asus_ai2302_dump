#!/system/bin/sh

echo "PCBID TEST: +++"

rm /data/data/pcbid_status_str_tmp

PROP_STAGE=$(getprop ro.boot.id.stage)
PROP_PROJECT=$(getprop ro.boot.id.prj)
PROP_SOC=$(getprop ro.boot.id.soc)

STAGE=
PROJECT=

case $PROP_PROJECT in
	"4" )
		PROJECT='AI2302'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
esac


case $PROP_STAGE in
	"0" )
		STAGE='SR1'
		echo "PCBID TEST: STAGE="$STAGE
		;;
	"1" )
		STAGE='SR2'
		echo "PCBID TEST: STAGE="$STAGE
		;;
	"8" )
		STAGE='SR_POWER'
		echo "PCBID TEST: STAGE="$STAGE
		;;
	"9" )
		STAGE='ER'
		echo "PCBID TEST: STAGE="$STAGE
		;;
	"12" )
		STAGE='PR'
		echo "PCBID TEST: STAGE="$STAGE
		;;
	"15" )
		STAGE='MP'
		echo "PCBID TEST: STAGE="$STAGE
		;;
	*)
		STAGE='UNKNOW('$PROP_STAGE')'
		echo "PCBID TEST: STAGE="$STAGE
		;;
esac


echo $PROJECT"_"$STAGE > /data/data/pcbid_status_str_tmp
chmod 00777 /data/data/pcbid_status_str_tmp

echo "PCBID TEST: ---"
