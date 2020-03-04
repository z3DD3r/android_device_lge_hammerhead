/*
 * Copyright (C) 2019-2020 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "android.hardware.light@2.0-service.hh"

#include <android/hardware/light/2.0/ILight.h>
#include <hidl/HidlSupport.h>
#include <hidl/HidlTransportSupport.h>
#include <utils/Errors.h>
#include <utils/StrongPointer.h>

#include "Light.h"

using android::hardware::configureRpcThreadpool;
using android::hardware::joinRpcThreadpool;
using android::hardware::light::V2_0::ILight;
using android::hardware::light::V2_0::implementation::Light;

const static std::string kBacklightPath = "/sys/class/leds/lcd-backlight/brightness";

const static std::string kRLedBrightnessPath = "/sys/class/leds/red/brightness";
const static std::string kGLedBrightnessPath = "/sys/class/leds/green/brightness";
const static std::string kBLedBrightnessPath = "/sys/class/leds/blue/brightness";

const static std::string kRLedTimeoutPath = "/sys/class/leds/red/on_off_ms";
const static std::string kGLedTimeoutPath = "/sys/class/leds/green/on_off_ms";
const static std::string kBLedTimeoutPath = "/sys/class/leds/blue/on_off_ms";

const static std::string kRLedLockedPath = "/sys/class/leds/red/rgb_start";
const static std::string kGLedLockedPath = "/sys/class/leds/green/rgb_start";
const static std::string kBLedLockedPath = "/sys/class/leds/blue/rgb_start";

android::status_t registerLightService() {
    std::ofstream backlight(kBacklightPath);
    if (!backlight) {
        int error = errno;
        ALOGE("Failed to open %s (%d): %s", kBacklightPath.c_str(), error, strerror(error));
        return -error;
    }

    std::ofstream rLedBrightness(kRLedBrightnessPath);
    if (!rLedBrightness) {
        int error = errno;
        ALOGE("Failed to open %s (%d): %s", kRLedBrightnessPath.c_str(), error, strerror(error));
        return -error;
    }

    std::ofstream gLedBrightness(kGLedBrightnessPath);
    if (!gLedBrightness) {
        int error = errno;
        ALOGE("Failed to open %s (%d): %s", kGLedBrightnessPath.c_str(), error, strerror(error));
        return -error;
    }

    std::ofstream bLedBrightness(kBLedBrightnessPath);
    if (!bLedBrightness) {
        int error = errno;
        ALOGE("Failed to open %s (%d): %s", kBLedBrightnessPath.c_str(), error, strerror(error));
        return -error;
    }

    std::ofstream rLedTimeout(kRLedTimeoutPath);
    if (!rLedTimeout) {
        int error = errno;
        ALOGE("Failed to open %s (%d): %s", kRLedTimeoutPath.c_str(), error, strerror(error));
        return -error;
    }

    std::ofstream gLedTimeout(kGLedTimeoutPath);
    if (!gLedTimeout) {
        int error = errno;
        ALOGE("Failed to open %s (%d): %s", kGLedTimeoutPath.c_str(), error, strerror(error));
        return -error;
    }

    std::ofstream bLedTimeout(kBLedTimeoutPath);
    if (!bLedTimeout) {
        int error = errno;
        ALOGE("Failed to open %s (%d): %s", kBLedTimeoutPath.c_str(), error, strerror(error));
        return -error;
    }

    std::ofstream rLedLocked(kRLedLockedPath);
    if (!rLedLocked) {
        int error = errno;
        ALOGE("Failed to open %s (%d): %s", kRLedLockedPath.c_str(), error, strerror(error));
        return -error;
    }

    std::ofstream gLedLocked(kGLedLockedPath);
    if (!gLedLocked) {
        int error = errno;
        ALOGE("Failed to open %s (%d): %s", kGLedLockedPath.c_str(), error, strerror(error));
        return -error;
    }

    std::ofstream bLedLocked(kBLedLockedPath);
    if (!bLedLocked) {
        int error = errno;
        ALOGE("Failed to open %s (%d): %s", kBLedLockedPath.c_str(), error, strerror(error));
        return -error;
    }

    android::sp<ILight> service = new Light(std::move(backlight),
                                            std::move(rLedBrightness),
                                            std::move(gLedBrightness),
                                            std::move(bLedBrightness),
                                            std::move(rLedTimeout),
                                            std::move(gLedTimeout),
                                            std::move(bLedTimeout),
                                            std::move(rLedLocked),
                                            std::move(gLedLocked),
                                            std::move(bLedLocked));
    if (!service) {
        ALOGE("Cannot allocate Light HAL service");
        return 1;
    }

    android::status_t status = service->registerAsService();
    if (status != android::OK) {
        ALOGE("Cannot register Light HAL service");
        return 1;
    }

    return android::OK;
}

int main() {
    configureRpcThreadpool(1, true);

    android::status_t status = registerLightService();
    if (status != android::OK) {
        return status;
    }

    joinRpcThreadpool();
}
