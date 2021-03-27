# TimeKeep

TimeKeep is a small utility to keep track of time & date since the RTC 
driver on Qualcomm chipset is read-only.

It consist of two parts. A native tool, timekeep, to store and restore time and a Java 
part (com.sony.timekeep) consisting of a single broadcastreceiver that receives 
ACTION_TIME_CHANGED, ACTION_TIMEZONE_CHANGED and ACTION_SHUTDOWN and then calls timekeep.

When the Java broadcastreceiver gets one of the above intents, timekeep is called with
store parameter and the time delta between the set date (in seconds) and 
/sys/class/rtc/rtc0/since_epoch is stored to a persistent property (persist.vendor.timeadjust).

To restore the time timekeep is called with the restore parameter. The persistent property
containing the time delta is then read together with the since_epoch value and settimeofday
is set with the sum of the two. timekeep with the restore parameter needs CAP_SYS_TIME.
The call to restore the time can for example be done in init as the example below.

init.example.rc:

on boot
  /system/bin/timekeep restore

