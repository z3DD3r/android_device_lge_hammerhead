# Graphics & display
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196608 \
    ro.sf.lcd_density=420 \
    persist.hwc.mdpcomp.enable=true \
    debug.hwui.use_buffer_age=false \
    drm.service.enabled=true

# Set sensor streaming rates
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

# WiFi
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15

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
    rild.libpath=/system/lib/libril-qc-qmi-1.so

# Allow tethering without provisioning app
PRODUCT_PROPERTY_OVERRIDES += \
    net.tethering.noprovisioning=true

# Camera configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    camera.disable_zsl_mode=1

# Input resampling configuration
PRODUCT_PROPERTY_OVERRIDES += \
    ro.input.noresample=1

# Reduce client buffer size for fast audio output tracks
PRODUCT_PROPERTY_OVERRIDES += \
    af.fast_track_multiplier=1

# Disable dex2oat swap
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-swap=false

# Dalvik heap
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=16m \
    dalvik.vm.heapgrowthlimit=192m \
    dalvik.vm.heapsize=512m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=2m \
    dalvik.vm.heapmaxfree=8m

# sdcardfs
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sys.sdcardfs=true

# Memory optimizations
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qti.am.reschedule_service=true \
    ro.vendor.qti.sys.fw.bservice_enable=true
