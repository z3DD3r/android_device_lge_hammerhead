/* 
 * Copyright (C) 2015 Sony Mobile Communications Inc.
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names
 *    of its contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <fcntl.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <sys/stat.h>
#include <time.h>

#define LOG_TAG "TimeKeep"

#include <cutils/properties.h>
#if ANDROID_SDK_VERSION >= 26
#include <log/log.h>
#else
#include <cutils/log.h>
#endif
#include <errno.h>

#define RTC_SYS_FILE "/sys/class/rtc/rtc0/since_epoch"
#if ANDROID_SDK_VERSION >= 26
#define RTC_ATS_FILE "/data/vendor/time/ats_2"
#else
#define RTC_ATS_FILE "/data/time/ats_2"
#endif
#define TIME_ADJUST_PROP "persist.vendor.timeadjust"

int read_epoch(unsigned long long* epoch) {
	int res = 0;

	int fd = open(RTC_SYS_FILE, O_RDONLY);
	if (fd == -1) {
		res = -errno;
		ALOGD("Failed to open RTC sys path");
	} else {
		char buffer[16];
		memset(buffer, 0, 16);
		res = read(fd, buffer, 16);
		if (res > 0) {
			char *endp = NULL;
			*epoch = strtoull(buffer, &endp, 10);
			// sysfs read returns newline, ok to end up at '\n'
			if (*endp != '\0' && *endp != '\n') {
				ALOGI("Read from " RTC_SYS_FILE " returned "
				      "invalid string %s (%s)", buffer, endp);
				res = -1;
			}
		}
	}

	return res;
}

/* ats_2 contains the time offset as 8-byte binary representation */
void restore_ats(uint64_t value) {
	FILE *fp = NULL;

	value *= 1000;
	fp = fopen(RTC_ATS_FILE, "wb");

	if (fp != NULL) {
		fwrite(&value, sizeof(value), 1, fp);
		fclose(fp);
	} else {
		ALOGI("Can't restore " RTC_ATS_FILE);
	}
}

int store_time() {
	char prop[PROPERTY_VALUE_MAX];
	unsigned long long seconds = 0;
	unsigned long long epoch_since = 0;
	int res = -1;
	struct tm tm;
	time_t t;

	// Get time and adjust for local time
	time(&t);
	localtime_r(&t, &tm);
	seconds = mktime(&tm);

	if (seconds > 0) {
		res = read_epoch(&epoch_since);
		if (res < 0) {
			ALOGI("Failed to read epoch while storing");
		} else {
			seconds -= epoch_since;
			snprintf(prop, PROPERTY_VALUE_MAX, "%llu", seconds);
			restore_ats(seconds);
			property_set(TIME_ADJUST_PROP, prop);
			ALOGI("Time adjustment stored to property");
			res = 0;
		}
	}

	return res;
}


int restore_time() {
	struct timeval tv;
	unsigned long long time_adjust = 0;
	unsigned long long epoch_since = 0;
	int res = -1;
	char prop[PROPERTY_VALUE_MAX];
	memset(prop, 0x0, PROPERTY_VALUE_MAX);
	property_get(TIME_ADJUST_PROP, prop, "0");

	if (strcmp(prop, "0") != 0) {
		char *endp = NULL;
		time_adjust = strtoull(prop, &endp, 10);
		if (*endp != '\0') {
			ALOGI("Property in " TIME_ADJUST_PROP
			      " is not valid: %s (%d)", prop, errno);
			return res;
		}
	} else {
		ALOGI("No time adjust value found for restore");
		return res;
	}

	res = read_epoch(&epoch_since);
	if (res < 0) {
		ALOGI("Failed to read from " RTC_SYS_FILE
		      " (%d), bailing out", res);
	} else {
		restore_ats(time_adjust);
		tv.tv_sec = epoch_since + time_adjust;
		tv.tv_usec = 0;
		res = settimeofday(&tv, NULL);
		if (res != 0) {
			ALOGI("Failed to restore time (%d), root?",
			      res);
		} else {
			ALOGI("Time restored!");
		}
	}

	return res;
}

int main(int argc, char* argv[]) {
	int res = -1;
	if (argc != 2) {
		ALOGI("usage: timekeep store|restore");
		return res;
	}

	// Keep CAP_SYS_TIME and drop to system user

	if (strcmp(argv[1], "store") == 0) {
		res = store_time();
	}

	if (strcmp(argv[1], "restore") == 0) {
		res = restore_time();
	}

	return res;
}
