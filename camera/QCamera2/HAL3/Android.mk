LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
        QCamera3Factory.cpp \
        QCamera3Hal.cpp \
        QCamera3HWI.cpp \
        QCamera3Mem.cpp \
        QCamera3Stream.cpp \
        QCamera3Channel.cpp \
        QCamera3PostProc.cpp \
        QCamera3VendorTags.cpp \
        ../util/QCameraCmdThread.cpp \
        ../util/QCameraFlash.cpp \
        ../util/QCameraQueue.cpp

LOCAL_CFLAGS := -Wall -Werror
LOCAL_CFLAGS += -DHAS_MULTIMEDIA_HINTS

# QCamera3Factory.cpp has unused parameters.
LOCAL_CFLAGS += -Wno-unused-parameter
# QCamera3Channel.cpp compares array 'str' to a null pointer.
LOCAL_CLANG_CFLAGS += -Wno-tautological-pointer-compare

LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/../stack/common \
        frameworks/native/include/media/openmax \
        frameworks/native/include \
        frameworks/av/include \
        system/media/camera/include \
        $(LOCAL_PATH)/../../mm-image-codec/qexif \
        $(LOCAL_PATH)/../../mm-image-codec/qomx_core \
        $(LOCAL_PATH)/../util

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
LOCAL_C_INCLUDES += \
        $(call project-path-for,qcom-media)/libstagefrighthw \
        $(call project-path-for,qcom-display)/libgralloc
else
LOCAL_C_INCLUDES += \
        hardware/qcom/media/msm8974/libstagefrighthw \
        hardware/qcom/display/msm8974/libgralloc
endif

LOCAL_HEADER_LIBRARIES := generated_kernel_headers
LOCAL_HEADER_LIBRARIES += media_plugin_headers

LOCAL_SHARED_LIBRARIES := libcamera_client liblog libhardware libutils libcutils libdl libsync
LOCAL_SHARED_LIBRARIES += libmmcamera_interface libmmjpeg_interface libui libcamera_metadata

#LOCAL_MODULE := camera.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE := camera.$(TARGET_DEVICE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)

#include $(LOCAL_PATH)/test/Android.mk
