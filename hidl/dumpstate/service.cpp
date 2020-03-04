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

#define LOG_TAG "android.hardware.dumpstate@1.0-service.hh"

#include <android/hardware/dumpstate/1.0/IDumpstateDevice.h>
#include <hidl/HidlSupport.h>
#include <hidl/HidlTransportSupport.h>
#include <utils/Errors.h>
#include <utils/StrongPointer.h>

#include "DumpstateDevice.h"

using android::hardware::configureRpcThreadpool;
using android::hardware::joinRpcThreadpool;
using android::hardware::dumpstate::V1_0::IDumpstateDevice;
using android::hardware::dumpstate::V1_0::implementation::DumpstateDevice;

android::status_t registerDumpstateService() {
    android::sp<IDumpstateDevice> service = new DumpstateDevice();
    if (!service) {
        ALOGE("Cannot allocate Dumpstate HAL service");
        return 1;
    }

    android::status_t status = service->registerAsService();
    if (status != android::OK) {
        ALOGE("Cannot register Dumpstate HAL service");
        return 1;
    }

    return android::OK;
}

int main() {
    configureRpcThreadpool(1, true);

    android::status_t status = registerDumpstateService();
    if (status != android::OK) {
        return status;
    }

    joinRpcThreadpool();
}
