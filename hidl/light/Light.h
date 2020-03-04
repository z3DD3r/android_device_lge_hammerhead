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

#ifndef ANDROID_HARDWARE_LIGHT_V2_0_LIGHT_H
#define ANDROID_HARDWARE_LIGHT_V2_0_LIGHT_H

#include <android/hardware/light/2.0/ILight.h>
#include <hidl/Status.h>

#include <fstream>
#include <mutex>
#include <unordered_map>

namespace android {
namespace hardware {
namespace light {
namespace V2_0 {
namespace implementation {

struct Light : public ILight {
    Light(std::ofstream&& backlight,
          std::ofstream&& rLedBrightness,
          std::ofstream&& gLedBrightness,
          std::ofstream&& bLedBrightness,
          std::ofstream&& rLedTimeout,
          std::ofstream&& gLedTimeout,
          std::ofstream&& bLedTimeout,
          std::ofstream&& rLedLocked,
          std::ofstream&& gLedLocked,
          std::ofstream&& bLedLocked);

    Return<Status> setLight(Type type, const LightState& state)  override;
    Return<void> getSupportedTypes(getSupportedTypes_cb _hidl_cb)  override;

private:
    void setBacklight(const LightState& state);

    void setNotificationLight(const LightState& state);
    void setAttentionLight(const LightState& state);
    void setBatteryLight(const LightState& state);

    void setPrioritizedLightLocked();
    void setLightStateLocked(const LightState& state);
    void setLightLocked(uint32_t color, int onMS, int offMS);

    std::ofstream mBacklight;
    std::ofstream mRLedBrightness;
    std::ofstream mGLedBrightness;
    std::ofstream mBLedBrightness;
    std::ofstream mRLedTimeout;
    std::ofstream mGLedTimeout;
    std::ofstream mBLedTimeout;
    std::ofstream mRLedLocked;
    std::ofstream mGLedLocked;
    std::ofstream mBLedLocked;

    LightState mNotificationState;
    LightState mAttentionState;
    LightState mBatteryState;

    std::unordered_map<Type, std::function<void(const LightState&)>> mLights;
    std::mutex mLock;
};

}  // namespace implementation
}  // namespace V2_0
}  // namespace light
}  // namespace hardware
}  // namespace android

#endif  // ANDROID_HARDWARE_LIGHT_V2_0_LIGHT_H
