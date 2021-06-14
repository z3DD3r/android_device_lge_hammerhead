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

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := krait

# Binder API version
TARGET_USES_64_BIT_BINDER := true

TARGET_NO_BOOTLOADER := true

BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048

BOARD_KERNEL_CMDLINE := console=none androidboot.hardware=hammerhead user_debug=31 maxcpus=4 msm_watchdog_v2.enable=1 androidboot.bootdevice=msm_sdcc.1
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02900000 --tags_offset 0x02700000
BOARD_KERNEL_IMAGE_NAME := zImage-dtb

# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

BOARD_USES_ALSA_AUDIO := true
USE_XML_AUDIO_POLICY_CONF := 1

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_CUSTOM_BT_CONFIG := device/lge/hammerhead/bluetooth/vnd_hammerhead.txt
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lge/hammerhead/bluetooth

# Filesystem
TARGET_FS_CONFIG_GEN := device/lge/hammerhead/config.fs

# Wifi related defines
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WLAN_DEVICE           := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true

BOARD_USES_SECURE_SERVICES := true

TARGET_NO_RADIOIMAGE := true
TARGET_BOARD_PLATFORM := msm8974
TARGET_BOOTLOADER_BOARD_NAME := hammerhead
TARGET_BOARD_INFO_FILE := device/lge/hammerhead/board-info.txt
TARGET_NO_RPC := true

VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000
TARGET_USES_ION := true
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS := 0x2000U | 0x02000000U
TARGET_SCREEN_DENSITY := 480
TARGET_DISABLE_POSTRENDER_CLEANUP := true

# Dex-preopt
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    WITH_DEXPREOPT ?= true
  endif
endif
DONT_DEXPREOPT_PREBUILTS := true
WITH_DEXPREOPT_DEBUG_INFO := false
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := true

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 23068672
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 23068672
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1073741824
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13725837312
BOARD_CACHEIMAGE_PARTITION_SIZE := 734003200
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072

BOARD_ROOT_EXTRA_FOLDERS := firmware persist
BOARD_ROOT_EXTRA_SYMLINKS += /vendor/etc:/vtc
BOARD_ROOT_EXTRA_SYMLINKS += /data/tombstones:/tombstones

# Define kernel config for inline building
TARGET_KERNEL_CONFIG := lineageos_hammerhead_defconfig
TARGET_KERNEL_SOURCE := kernel/lge/hammerhead

TARGET_RECOVERY_FSTAB = device/lge/hammerhead/fstab.hammerhead

TARGET_RELEASETOOLS_EXTENSIONS := device/lge/hammerhead

# QCOM selinux policies
include device/qcom/sepolicy-legacy/sepolicy.mk

BOARD_VENDOR_SEPOLICY_DIRS += device/lge/hammerhead/sepolicy/vendor
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/lge/hammerhead/sepolicy/private

DEVICE_MANIFEST_FILE := device/lge/hammerhead/manifest.xml
DEVICE_MATRIX_FILE := device/lge/hammerhead/compatibility_matrix.xml

TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
TARGET_HAS_HH_VSYNC_ISSUE := true

TARGET_TOUCHBOOST_FREQUENCY:= 1200

USE_DEVICE_SPECIFIC_QCOM_PROPRIETARY:= true
TARGET_PROCESS_SDK_VERSION_OVERRIDE := \
    /system/bin/cameraserver=22 \
    /system/bin/mediaserver=22 \
    /vendor/bin/mm-qcamera-daemon=22

TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS:= true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

ifneq ($(TARGET_BUILD_VARIANT),user)
SELINUX_IGNORE_NEVERALLOWS := true
endif

# Shims
TARGET_LD_SHIM_LIBS := \
    /vendor/bin/mpdecision|libshim_atomic.so \
    /vendor/lib/libril-qc-qmi-1.so|libshim_ril.so

# Power
TARGET_USES_INTERACTION_BOOST := true

# Legacy memfd
TARGET_HAS_MEMFD_BACKPORT := true

# Tweaks for 'low ram' devices
-include device/lge/hammerhead/lowram/BoardConfig.mk

-include vendor/lge/hammerhead/BoardConfigVendor.mk
