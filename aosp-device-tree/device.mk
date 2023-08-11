#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Include GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# Rootdir
PRODUCT_PACKAGES += \
    SelfTestOpenHalf.sh \
    init.qcom.sdio.sh \
    firmware_version.sh \
    init.qti.kernel.sh \
    WifiSARPower.sh \
    init.qti.kernel.early_debug-kalama.sh \
    SelfTestClose.sh \
    init.qcom.usb.sh \
    init.qti.display_boot.sh \
    widevine.sh \
    shutdown_debug.sh \
    erase_batinfo.sh \
    SelfTestOpen.sh \
    init.asus.check_last.sh \
    init.asus.changebinder.sh \
    init.asus.check_asdf.sh \
    magnetometer_accessory_installed.sh \
    init.qcom.class_core.sh \
    init.qcom.coex.sh \
    cat_pcbid.sh \
    create_pcbid.sh \
    magnetometer_accessory2_installed.sh \
    magnetometer_accessory_removed.sh \
    cscclearlog.sh \
    savelogmtp.sh \
    LightFingerprintPosition.sh \
    init.kernel.post_boot.sh \
    ufs_info.sh \
    init.qti.media.sh \
    asus_ufs_check.sh \
    vendor_modprobe.sh \
    qca6234-service.sh \
    LcdPanel_VendorID.sh \
    vendor_savelogs.sh \
    system_dlkm_modprobe.sh \
    WifiMac.sh \
    grip_vib_request.sh \
    grip_cal.sh \
    init.asus.zram.sh \
    grip_fpc_check.sh \
    compare_wlc_fw_version.sh \
    gf_ver.sh \
    asus_ufs_init.sh \
    grip_read_fw_status.sh \
    sensors_factory_init.sh \
    init.qti.write.sh \
    ufs_fw.sh \
    grip_chip_status_check.sh \
    init.qcom.sh \
    NfcFelica.sh \
    touch_ver.sh \
    init.qcom.post_boot.sh \
    init.qti.kernel.debug-kalama.sh \
    init.kernel.post_boot-kalama.sh \
    tdoor_load_cal.sh \
    ssr_cfg.sh \
    init.mdm.sh \
    init.qcom.sensors.sh \
    init.crda.sh \
    asus_ufs_shutdown.sh \
    init.qcom.early_boot.sh \
    PanelFrameRate.sh \
    BLPower.sh \
    init.class_main.sh \
    init.qti.kernel.early_debug.sh \
    init.qcom.efs.sync.sh \
    init.qti.qcv.sh \
    init.qti.kernel.debug.sh \

PRODUCT_PACKAGES += \
    fstab.qcom \
    init.qti.ufs.rc \
    init.qcom.rc \
    init.asus.rc \
    init.qti.kernel.rc \
    init.qcom.factory.rc \
    init.qcom.usb.rc \
    init.asus.debugtool.rc \
    init.target.rc \
    init.recovery.qcom.rc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.qcom

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 33

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/asus/ASUS_AI2302/ASUS_AI2302-vendor.mk)
