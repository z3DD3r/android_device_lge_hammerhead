OLD_LOCAL_PATH := $(LOCAL_PATH)
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

MM_CAM_FILES := \
        src/mm_camera_interface.c \
        src/mm_camera.c \
        src/mm_camera_channel.c \
        src/mm_camera_stream.c \
        src/mm_camera_thread.c \
        src/mm_camera_sock.c

ifeq ($(strip $(TARGET_USES_ION)),true)
    LOCAL_CFLAGS += -DUSE_ION
endif

ifeq ($(call is-board-platform-in-list,msm8974 msm8226),true)
    LOCAL_CFLAGS += -DVENUS_PRESENT
endif

LOCAL_CFLAGS += -D_ANDROID_

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/inc \
    $(LOCAL_PATH)/../common

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
LOCAL_C_INCLUDES += \
        $(call project-path-for,qcom-media)/mm-core/inc
else
LOCAL_C_INCLUDES += \
        hardware/qcom/media/msm8974/mm-core/inc
endif

LOCAL_HEADER_LIBRARIES := generated_kernel_headers
LOCAL_HEADER_LIBRARIES += media_plugin_headers

LOCAL_CFLAGS += -Wall -Werror

LOCAL_SRC_FILES := $(MM_CAM_FILES)

LOCAL_MODULE           := libmmcamera_interface
LOCAL_SHARED_LIBRARIES := libdl libcutils liblog
LOCAL_HEADER_LIBRARIES += camera_common_headers
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := camera_common_headers
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/../common
include $(BUILD_HEADER_LIBRARY)

LOCAL_PATH := $(OLD_LOCAL_PATH)
