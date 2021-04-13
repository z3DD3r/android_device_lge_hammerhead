#
# Copyright (C) 2013 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file includes all definitions that apply to ALL hammerhead devices, and
# are also specific to hammerhead devices
#
# Everything in this directory will become public

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# APEX
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ld.config.txt:$(TARGET_COPY_OUT_VENDOR)/etc/swcodec/ld.config.txt

# HIDL
PRODUCT_ENFORCE_VINTF_MANIFEST_OVERRIDE := true

# Speed profile services and wifi-service to reduce RAM and storage.
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile

# Always preopt extracted APKs to prevent extracting out of the APK for gms
# modules.
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true

# Use a profile based boot image for this device. Note that this is currently a
# generic profile and not Android Go optimized.
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := frameworks/base/config/boot-image-profile.txt

# Do not generate libartd.
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Do not spin up a separate process for the network stack on go devices, use an in-process APK.
PRODUCT_PACKAGES += InProcessNetworkStack
PRODUCT_PACKAGES += com.android.tethering.inprocess

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable Scudo outside of eng builds to save RAM.
PRODUCT_DISABLE_SCUDO := true

PRODUCT_COPY_FILES += \
    device/lge/hammerhead/init.hammerhead.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.hammerhead.rc \
    device/lge/hammerhead/init.hammerhead.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.hammerhead.usb.rc \
    device/lge/hammerhead/init.recovery.hammerhead.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.hammerhead.rc \
    device/lge/hammerhead/init.recovery.hammerhead.usb.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.hammerhead.usb.rc \
    device/lge/hammerhead/fstab.hammerhead:$(TARGET_COPY_OUT_RAMDISK)/fstab.hammerhead \
    device/lge/hammerhead/fstab.hammerhead:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.hammerhead \
    device/lge/hammerhead/ueventd.hammerhead.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc

# Input device files for hammerhead
PRODUCT_COPY_FILES += \
    device/lge/hammerhead/gpio-keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/gpio-keys.kl \
    device/lge/hammerhead/gpio-keys.kcm:$(TARGET_COPY_OUT_VENDOR)/usr/keychars/gpio-keys.kcm \
    device/lge/hammerhead/qpnp_pon.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/qpnp_pon.kl \
    device/lge/hammerhead/qpnp_pon.kcm:$(TARGET_COPY_OUT_VENDOR)/usr/keychars/qpnp_pon.kcm \
    device/lge/hammerhead/Button_Jack.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/msm8974-taiko-mtp-snd-card_Button_Jack.kl \
    device/lge/hammerhead/Button_Jack.kcm:$(TARGET_COPY_OUT_VENDOR)/usr/keychars/msm8974-taiko-mtp-snd-card_Button_Jack.kcm \
    device/lge/hammerhead/hs_detect.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/hs_detect.kl \
    device/lge/hammerhead/hs_detect.kcm:$(TARGET_COPY_OUT_VENDOR)/usr/keychars/hs_detect.kcm

# Prebuilt input device calibration files
PRODUCT_COPY_FILES += \
    device/lge/hammerhead/touch_dev.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/touch_dev.idc

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    device/lge/hammerhead/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \
    device/lge/hammerhead/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    device/lge/hammerhead/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \
    device/lge/hammerhead/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    device/lge/hammerhead/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    device/lge/hammerhead/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

PRODUCT_COPY_FILES += \
    device/lge/hammerhead/bcmdhd.cal:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/bcmdhd.cal

PRODUCT_COPY_FILES += \
    device/lge/hammerhead/bluetooth/BCM4339_003.001.009.0079.0339.hcd:$(TARGET_COPY_OUT_VENDOR)/firmware/bcm4335c0.hcd

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# For GPS
PRODUCT_COPY_FILES += \
    device/lge/hammerhead/sec_config:$(TARGET_COPY_OUT_VENDOR)/etc/sec_config

# NFC access control + feature files + configuration
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    device/lge/hammerhead/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci.conf \
    device/lge/hammerhead/nfc/libnfc-nci-20791b05.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci-20791b05.conf

PRODUCT_COPY_FILES += \
    device/lge/hammerhead/thermal-engine-8974.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-8974.conf

# Privapp Whitelist
PRODUCT_COPY_FILES += \
    device/lge/hammerhead/permissions/privapp-permissions-hammerhead.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/privapp-permissions-hammerhead.xml

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

PRODUCT_CHARACTERISTICS := nosdcard

DEVICE_PACKAGE_OVERLAYS := \
    device/lge/hammerhead/overlay

PRODUCT_ENFORCE_RRO_TARGETS := *
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    $(LOCAL_PATH)/overlay/lineage-sdk \
    $(LOCAL_PATH)/overlay/packages/apps/Snap

PRODUCT_PACKAGES := \
    android.hardware.wifi@1.0-service.legacy \
    libwpa_client \
    hostapd \
    wificond \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service \
    libbt-vendor

# LiveDisplay
PRODUCT_PACKAGES += \
    vendor.lineage.livedisplay@2.0-service-sysfs

# TimeKeep
PRODUCT_PACKAGES += \
    timekeep \
    TimeKeep

# Trust HAL
PRODUCT_PACKAGES += \
    vendor.lineage.trust@1.0-service

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    librs_jni

PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    memtrack.msm8974 \
    libqdutils \
    libqdMetaData

# RenderScript HAL
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libstagefrighthw \
    libOmxCore \
    libmm-omxcore \
    libOmxVdec \
    libOmxVdecHevc \
    libOmxVenc

PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-impl \
    android.hardware.audio@2.0-service \
    audio.primary.msm8974 \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    libaudio-resampler

# Audio effects
PRODUCT_PACKAGES += \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.audio.effect@2.0-service \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libqcomvoiceprocessingdescriptors \
    libqcompostprocbundle

PRODUCT_COPY_FILES += \
    device/lge/hammerhead/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml


# Camera
PRODUCT_PACKAGES += \
    libqomx_core \
    camera.device@3.2-impl \
    libmmcamera_interface \
    libmmjpeg_interface \
    android.hardware.camera.provider@2.4-impl \
    camera.hammerhead \
    mm-jpeg-interface-test \
    mm-qcamera-app \
    Snap

PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# GPS configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps/etc/flp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/flp.conf \
    $(LOCAL_PATH)/gps/etc/gps.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gps.conf \
    $(LOCAL_PATH)/gps/etc/izat.conf:$(TARGET_COPY_OUT_VENDOR)/etc/izat.conf \
    $(LOCAL_PATH)/gps/etc/sap.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sap.conf

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl.legacy \
    android.hardware.gnss@1.0-service.legacy \
    libgps.utils \
    gps.msm8974

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# NFC packages
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.0-impl-bcm \
    android.hardware.nfc@1.0-service \
    nfc_nci.bcm2079x.default \
    NfcNci \
    Tag

# Recorder
PRODUCT_PACKAGES += \
    Recorder

# Seccomp
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/seccomp/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    $(LOCAL_PATH)/seccomp/mediaextractor.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy

# Dumpstate HAL
PRODUCT_PACKAGES += \
    android.hardware.dumpstate@1.0-service.hh

# Vibrator HAL
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.1-service.hh

PRODUCT_PACKAGES += \
    libion

# Light HAL
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.hh

PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# USB HAL service
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service.basic

# Filesystem management tools
PRODUCT_PACKAGES += \
    resize2fs_static \
    e2fsck

PRODUCT_PACKAGES += \
    bdAddrLoader

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.hh

PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196608

PRODUCT_PROPERTY_OVERRIDES += \
    persist.hwc.mdpcomp.enable=true

PRODUCT_PROPERTY_OVERRIDES += \
    debug.hwui.use_buffer_age=false

PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.disable_backpressure=1

PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.latch_unsignaled=1

PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.recomputecrop=0

PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.3-service.clearkey

# FastCharge
PRODUCT_PACKAGES += \
    vendor.lineage.fastcharge@1.0-service.hh

PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl

# Shims
PRODUCT_PACKAGES += \
    libshim_atomic

# RIL shims
PRODUCT_PACKAGES += \
    libshim_ril

# AptX
PRODUCT_COPY_FILES += \
    device/lge/hammerhead/aptx/lib/libaptX_encoder.so:$(TARGET_COPY_OUT_VENDOR)/lib/libaptX_encoder.so \
    device/lge/hammerhead/aptx/lib/libaptXHD_encoder.so:$(TARGET_COPY_OUT_VENDOR)/lib/libaptXHD_encoder.so

PRODUCT_PROPERTY_OVERRIDES += \
    persist.bt.enableAptXHD=true \
    persist.service.btui.use_aptx=1 \
    persist.vendor.bt.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldac \
    persist.vendor.btstack.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldac

# Set sensor streaming rate
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qti.sensors.max_geomag_rotv=60 \
    ro.qti.sensors.max_gyro_rate=200 \
    ro.qti.sensors.max_accel_rate=200 \
    ro.qti.sensors.max_grav=200 \
    ro.qti.sensors.max_rotvec=200 \
    ro.qti.sensors.max_orient=200 \
    ro.qti.sensors.max_linacc=200 \
    ro.qti.sensors.max_gamerv_rate=200

# Enable optional sensor types
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qti.sensors.smd=true \
    ro.qti.sensors.game_rv=true \
    ro.qti.sensors.georv=true \
    ro.qti.sensors.smgr_mag_cal_en=true \
    ro.qti.sensors.step_detector=true \
    ro.qti.sensors.step_counter=true \
    ro.qti.sensors.tap=false \
    ro.qti.sensors.facing=false \
    ro.qti.sensors.tilt=false \
    ro.qti.sensors.amd=false \
    ro.qti.sensors.rmd=false \
    ro.qti.sensors.vmd=false \
    ro.qti.sensors.pedometer=false \
    ro.qti.sensors.pam=false \
    ro.qti.sdk.sensors.gestures=false

# Enable some debug messages by default
PRODUCT_PROPERTY_OVERRIDES += \
    persist.debug.sensors.hal=w \
    debug.qualcomm.sns.daemon=w \
    debug.qualcomm.sns.libsensor1=w

# Ril sends only one RIL_UNSOL_CALL_RING, so set call_ring.multiple to false
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.call_ring.multiple=0

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15

PRODUCT_PROPERTY_OVERRIDES += \
    debug.stagefright.omx_default_rank.sw-audio=1 \
    debug.stagefright.omx_default_rank=0

# codec2
PRODUCT_PROPERTY_OVERRIDES += \
    debug.stagefright.ccodec=0

# Enable AAC 5.1 output
PRODUCT_PROPERTY_OVERRIDES += \
    media.aac_51_output_enabled=true

# Do not power down SIM card when modem is sent to Low Power Mode.
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.apm_sim_not_pwdn=1

# LTE, CDMA, GSM/WCDMA
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ril.force_eri_from_xml=true \
    ro.telephony.default_network=10 \
    telephony.lteOnCdmaDevice=1 \
    persist.radio.mode_pref_nv10=1

# update 1x signal strength after 2s
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.radio.snapshot_enabled=1 \
    persist.radio.snapshot_timer=2

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.radio.use_cc_names=true

# If data_no_toggle is 1 then active and dormancy enable at all times.
# If data_no_toggle is 0 there are no reports if the screen is off.
# Leaving this property unset defaults to '0'
# Due to RIL changes, setting this to 1 now enables toggling of limited
# system indications and does not impact data state changes.
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.data_no_toggle=1

# Audio Configuration
PRODUCT_PROPERTY_OVERRIDES += \
    persist.audio.handset.mic.type=digital \
    persist.audio.dualmic.config=endfire \
    persist.audio.fluence.voicecall=true \
    persist.audio.fluence.voicecomm=true \
    persist.audio.fluence.voicerec=false \
    persist.audio.fluence.speaker=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.vc_call_vol_steps=7 \
    ro.config.media_vol_steps=25

# Setup custom emergency number list based on the MCC. This is needed by RIL
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.custom_ecc=1

# Request modem to send PLMN name always irrespective
# of display condition in EFSPN.
# RIL uses this property.
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.always_send_plmn=true

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    rild.libpath=/vendor/lib/libril-qc-qmi-1.so

# Allow tethering without provisioning app
PRODUCT_PROPERTY_OVERRIDES += \
    net.tethering.noprovisioning=true

# Camera configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    camera.disable_zsl_mode=1

# SurfaceFlinger
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.force_hwc_copy_for_virtual_displays=true \
    ro.surface_flinger.vsync_event_phase_offset_ns=7500000 \
    ro.surface_flinger.vsync_sf_event_phase_offset_ns=5000000

# Input resampling configuration
PRODUCT_PROPERTY_OVERRIDES += \
    ro.input.noresample=1

# Reduce client buffer size for fast audio output tracks
PRODUCT_PROPERTY_OVERRIDES += \
    af.fast_track_multiplier=1

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-swap=false

# Memory optimizations
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qti.am.reschedule_service=true \
    ro.vendor.qti.sys.fw.bservice_enable=true

# Storage
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sys.sdcardfs=true

# Dalvik heap
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=16m \
    dalvik.vm.heapgrowthlimit=192m \
    dalvik.vm.heapsize=512m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapmaxfree=8m

# Perf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=/vendor/lib/libqti-perfd-client.so

# Subsystem ramdump
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.ssr.enable_debug=0 \
    persist.sys.ssr.enable_ramdumps=0

# Charger
PRODUCT_PRODUCT_PROPERTIES += \
    ro.charger.enable_suspend=true

# Device was launched with K
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_k.mk)

# Broadcom WIFI driver
$(call inherit-product-if-exists, device/lge/hammerhead/wlan/bcmdhd/firmware/bcm4339/device-bcm.mk)

# Vendor security patch level
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lineage.build.vendor_security_patch=2016-10-05
