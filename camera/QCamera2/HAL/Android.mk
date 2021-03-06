LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
        QCamera2Factory.cpp \
        QCamera2Hal.cpp \
        QCamera2HWI.cpp \
        QCameraMem.cpp \
        ../util/QCameraQueue.cpp \
        ../util/QCameraCmdThread.cpp \
        QCameraStateMachine.cpp \
        QCameraChannel.cpp \
        QCameraStream.cpp \
        QCameraPostProc.cpp \
        QCamera2HWICallbacks.cpp \
        QCameraParameters.cpp \
        QCameraThermalAdapter.cpp

LOCAL_CFLAGS = -Wall -Werror -DDEFAULT_ZSL_MODE_ON -DDEFAULT_DENOISE_MODE_ON
#Debug logs are enabled
#LOCAL_CFLAGS += -DDISABLE_DEBUG_LOG

LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/../stack/common \
        frameworks/native/include/media/hardware \
        frameworks/native/include/media/openmax \
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

LOCAL_SHARED_LIBRARIES := libcamera_client liblog libhardware libutils libcutils libdl
LOCAL_SHARED_LIBRARIES += libmmcamera_interface libmmjpeg_interface

LOCAL_MODULE := camera.$(TARGET_BOARD_PLATFORM)
#LOCAL_MODULE := camera.$(TARGET_DEVICE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)
