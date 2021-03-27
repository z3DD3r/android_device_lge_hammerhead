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

package com.sony.timekeep;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.Long;
import java.lang.System;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.os.SystemProperties;

public class TimeKeep extends BroadcastReceiver {
	private static final String TAG = "TimeKeep-Receiver";
	private static final String TIMEADJ_PROP = "persist.vendor.timeadjust";
	private static final String RTC_SINCE_EPOCH = "/sys/class/rtc/rtc0/since_epoch";
	private static final String RTC_ATS_FILE = "/data/vendor/time/ats_2";

	@Override
	public void onReceive(Context context, Intent intent) {
		Log.d(TAG, "Got intent " + intent + ", storing time delta.");

		long seconds = System.currentTimeMillis()/1000;
		long epoch_since = readEpoch();
		seconds -= epoch_since;

		String currentAdjust = SystemProperties.get(TIMEADJ_PROP);

		Log.d(TAG, "Setting adjust property to " + seconds);
		SystemProperties.set(TIMEADJ_PROP, Long.toString(seconds));
		writeATS(seconds);
	}

	private long readEpoch() {
		FileInputStream fis;
		byte[] buffer = new byte[32];
		int read = 0;
		try {
			fis = new FileInputStream(RTC_SINCE_EPOCH);
			read = fis.read(buffer);
			fis.close();
		} catch (IOException e) {
			Log.e(TAG, "Failed to read " + RTC_SINCE_EPOCH);
			e.printStackTrace();
		}

		long epoch = 0;
		if (read > 0) {
			epoch = Integer.parseInt(new String(buffer).split("\n")[0]);
		}

		return epoch;
	}

	private void writeATS(long seconds) {
		BufferedOutputStream bos = null;
		long milliseconds = seconds * 1000;
		ByteBuffer buffer = ByteBuffer.allocate(8).order(ByteOrder.nativeOrder());
		buffer.putLong(milliseconds);
		try {
			bos = new BufferedOutputStream(new FileOutputStream(RTC_ATS_FILE, false));
			bos.write(buffer.array());
			bos.flush();
		} catch (FileNotFoundException ex) {
			Log.w(TAG, "file " + RTC_ATS_FILE + " not found: " + ex);
		} catch (IOException ex) {
			Log.w(TAG, "IOException trying to sync " + RTC_ATS_FILE + ": " + ex);
		} finally {
			if (bos != null) {
				try {
					Log.w(TAG, "file " + RTC_ATS_FILE + ": " + milliseconds);
					bos.close();
				} catch (IOException ex) {
					Log.w(TAG, "IOException while closing synced file: ", ex);
				}
			}
		}
	}
}
