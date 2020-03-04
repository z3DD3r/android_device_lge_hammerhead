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

#define LOG_TAG "LightService"
#include <log/log.h>

#include "Light.h"

namespace {

static bool isLit(android::hardware::light::V2_0::LightState& state) {
    return (state.color & 0x00ffffff);
}

static uint32_t rgbToBrightness(const android::hardware::light::V2_0::LightState& state) {
    uint32_t color = state.color & 0x00ffffff;
    return ((77 * ((color >> 16) & 0xff)) + (150 * ((color >> 8) & 0xff)) + (29 * (color & 0xff))) >> 8;
}

}  // anonymous namespace

namespace android {
namespace hardware {
namespace light {
namespace V2_0 {
namespace implementation {

Light::Light(std::ofstream&& backlight,
             std::ofstream&& rLedBrightness,
             std::ofstream&& gLedBrightness,
             std::ofstream&& bLedBrightness,
             std::ofstream&& rLedTimeout,
             std::ofstream&& gLedTimeout,
             std::ofstream&& bLedTimeout,
             std::ofstream&& rLedLocked,
             std::ofstream&& gLedLocked,
             std::ofstream&& bLedLocked) :
             mBacklight(std::move(backlight)),
             mRLedBrightness(std::move(rLedBrightness)),
             mGLedBrightness(std::move(gLedBrightness)),
             mBLedBrightness(std::move(bLedBrightness)),
             mRLedTimeout(std::move(rLedTimeout)),
             mGLedTimeout(std::move(gLedTimeout)),
             mBLedTimeout(std::move(bLedTimeout)),
             mRLedLocked(std::move(rLedLocked)),
             mGLedLocked(std::move(gLedLocked)),
             mBLedLocked(std::move(bLedLocked)) {
    auto attnFn(std::bind(&Light::setAttentionLight, this, std::placeholders::_1));
    auto backlightFn(std::bind(&Light::setBacklight, this, std::placeholders::_1));
    auto batteryFn(std::bind(&Light::setBatteryLight, this, std::placeholders::_1));
    auto notifFn(std::bind(&Light::setNotificationLight, this, std::placeholders::_1));

    mLights.emplace(std::make_pair(Type::ATTENTION, attnFn));
    mLights.emplace(std::make_pair(Type::BACKLIGHT, backlightFn));
    mLights.emplace(std::make_pair(Type::BATTERY, batteryFn));
    mLights.emplace(std::make_pair(Type::NOTIFICATIONS, notifFn));
}

Return<Status> Light::setLight(Type type, const LightState& state) {
    auto it = mLights.find(type);
    if (it == mLights.end()) {
        return Status::LIGHT_NOT_SUPPORTED;
    }
    it->second(state);
    return Status::SUCCESS;
}

Return<void> Light::getSupportedTypes(getSupportedTypes_cb _hidl_cb) {
    std::vector<Type> types;
    for (auto const& light : mLights) {
        types.push_back(light.first);
    }
    _hidl_cb(types);
    return Void();
}

void Light::setBacklight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    uint32_t brightness = rgbToBrightness(state);
    mBacklight << brightness << std::endl;
}

void Light::setNotificationLight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    mNotificationState = state;
    setPrioritizedLightLocked();
}

void Light::setAttentionLight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    mAttentionState = state;
    setPrioritizedLightLocked();
}

void Light::setBatteryLight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    mBatteryState = state;
    setPrioritizedLightLocked();
}

void Light::setPrioritizedLightLocked() {
    if (isLit(mNotificationState)) {
        setLightStateLocked(mNotificationState);
    } else if (isLit(mAttentionState)) {
        setLightStateLocked(mAttentionState);
    } else if (isLit(mBatteryState)) {
        setLightStateLocked(mBatteryState);
    } else {
        setLightLocked(0, 0, 0);
    }
}

void Light::setLightStateLocked(const LightState& state) {
    int onMS, offMS;
    uint32_t color = state.color & 0x00ffffff;

    switch (state.flashMode) {
        case Flash::TIMED:
        case Flash::HARDWARE:
            onMS = state.flashOnMs;
            offMS = state.flashOffMs;
            break;
        case Flash::NONE:
        default:
            onMS = 0;
            offMS = 0;
            break;
    }

    setLightLocked(color, onMS, offMS);
}

void Light::setLightLocked(uint32_t color, int onMS, int offMS) {
    uint32_t r = ((color >> 16) & 0xff);
    uint32_t g = ((color >> 8) & 0xff);
    uint32_t b = ((color) & 0xff);

    mRLedLocked << 0 << std::endl;
    mGLedLocked << 0 << std::endl;
    mBLedLocked << 0 << std::endl;

    mRLedBrightness << r << std::endl;
    mGLedBrightness << g << std::endl;
    mBLedBrightness << b << std::endl;

    mRLedTimeout << onMS << " " << offMS << std::endl;
    mGLedTimeout << onMS << " " << offMS << std::endl;
    mBLedTimeout << onMS << " " << offMS << std::endl;

    mRLedLocked << 1 << std::endl;
    mGLedLocked << 1 << std::endl;
    mBLedLocked << 1 << std::endl;
}

}  // namespace implementation
}  // namespace V2_0
}  // namespace light
}  // namespace hardware
}  // namespace android
