#!/vendor/bin/sh

#setprop vendor.asus.setenforce 1
#echo "[check key status] setenforce: permissive" > /proc/asusevtlog
setprop "vendor.atd.checkkeybox.finish" FALSE
#sleep 5

/vendor/bin/is_keybox_valid
/vendor/bin/is_keymaster_valid
/vendor/bin/is_hdcp_valid

ret=$(/vendor/bin/hdcp2p2prov -verify)
if [ "${ret}" = "Verification succeeded. Device is provisioned." ]; then
	setprop "vendor.atd.hdcp2p2.ready" TRUE
else
	setprop "vendor.atd.hdcp2p2.ready" FALSE
fi

ret=$(/vendor/bin/hdcp1prov -verify)
if [ "${ret}" = "Verification succeeded. Device is provisioned." ]; then
	setprop "vendor.atd.hdcp1.ready" TRUE
else
	setprop "vendor.atd.hdcp1.ready" FALSE
fi

#Debug purpose..
HDCP_READY=$(getprop vendor.atd.hdcp.ready)
HDCP1_READY=$(getprop vendor.atd.hdcp1.ready)
HDCP2P2_READY=$(getprop vendor.atd.hdcp2p2.ready)
KEYMASTER_READY=$(getprop vendor.atd.keymaster.ready)
KEYBOX_READY=$(getprop vendor.atd.keybox.ready)

# Log result.
log "[ABSP] vendor.atd.hdcp.ready = ${HDCP_READY}"
log "[ABSP] vendor.atd.hdcp1.ready = ${HDCP1_READY}"
log "[ABSP] vendor.atd.hdcp2p2.ready = ${HDCP2P2_READY}"
log "[ABSP] vendor.atd.keymaster.ready = ${KEYMASTER_READY}"
log "[ABSP] vendor.atd.keybox.ready = ${KEYBOX_READY}"

#Test
#setprop "vendor.atd.keybox.ready" FALSE
#KEYBOX_READY=$(getprop vendor.atd.keybox.ready)

i=0
while [ ${KEYBOX_READY} != "TRUE" -a $i -lt 30 ]
do
#	log "[keybox] check key retry $i"
	/vendor/bin/is_keybox_valid
	i=$(($i+1))
	sleep 5
	KEYBOX_READY=$(getprop vendor.atd.keybox.ready)
	log "[ABSP] retry=$i,vendor.atd.keybox.ready = ${KEYBOX_READY}"
done

setprop "vendor.atd.checkkeybox.finish" TRUE
#setprop vendor.asus.setenforce 0
#echo "[check key status] setenforce: enforcing" > /proc/asusevtlog
# start install_key_server
#setprop "vendor.atd.start.key.install" 1
