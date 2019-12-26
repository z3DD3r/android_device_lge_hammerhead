# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080
TARGET_BOOTANIMATION_HALF_RES := true

TARGET_USES_AOSP := true
TARGET_GAPPS_ARCH := arm
TARGET_MINIMAL_APPS := true

# Inherit basic aosp junk
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit some common aosp stuff
$(call inherit-product, vendor/aosp/config/common_full_phone.mk)

# Inherit device vendor
$(call inherit-product-if-exists, vendor/lge/hammerhead/hammerhead-vendor.mk)

# Inherit device configuration
$(call inherit-product, device/lge/hammerhead/device.mk)

# Inherit device-specific system properties
$(call inherit-product, device/lge/hammerhead/properties.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := hammerhead
PRODUCT_NAME := aosp_hammerhead
PRODUCT_BRAND := google
PRODUCT_MODEL := Nexus 5
PRODUCT_MANUFACTURER := LGE

PRODUCT_RESTRICT_VENDOR_FILES := false

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=hammerhead \
    PRIVATE_BUILD_DESC="hammerhead-user 6.0.1 M4B30Z 3437181 release-keys"

BUILD_FINGERPRINT := google/hammerhead/hammerhead:6.0.1/M4B30Z/3437181:user/release-keys
