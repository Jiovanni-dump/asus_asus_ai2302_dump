#!/vendor/bin/sh
BATT_WLC_FW_VERSION_PATH="/sys/class/qcom-battery/wireless_fw_version"
TARGET_VERSION=0x0f

compare_wlc_fw_version(){
    BATT_WLC_FW_VERSION=`cat $BATT_WLC_FW_VERSION_PATH`
    if(($BATT_WLC_FW_VERSION==$TARGET_VERSION))
    then
        echo "PASS#"$BATT_WLC_FW_VERSION
    else
        echo "FAIL#"$BATT_WLC_FW_VERSION"#"$TARGET_VERSION
    fi
}

compare_wlc_fw_version