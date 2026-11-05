import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../data/alarm.dart';

class LocalNotificationRepository {
  LocalNotificationRepository._();

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails("channel id", "channel name",
    channelDescription: "channel description",
    importance: Importance.max,
    priority: Priority.max,
    showWhen: true,
    largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
  );

  static const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: DarwinNotificationDetails(
      badgeNumber: 1,
    ),
  );

  static initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("mipmap/launcher_icon");

    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> requestPermission() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // static Future<void> sampleNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails("channel id", "channel name",
  //           channelDescription: "channel description",
  //           importance: Importance.max,
  //           priority: Priority.max,
  //           showWhen: true,
  //           largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
  //   );
  //
  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: DarwinNotificationDetails(
  //       badgeNumber: 1,
  //     ),
  //   );
  //
  //   await _flutterLocalNotificationsPlugin.show(
  //       0,
  //       'Duesday',
  //       "새 알람 D-1",
  //       platformChannelSpecifics,
  //       payload: "hellowwwww");
  // }

  static Future<void> setAdvancedAlarm(Alarm alarm,DateTime settingDate,int advancedDays) async {
    final now = DateTime.now();
    var scheduledTime = settingDate.subtract(Duration(days: advancedDays));
    if (!scheduledTime.isAfter(now)) {
      scheduledTime = nextAlarmOccurrence(alarm, now, advancedDays: advancedDays)
          .subtract(Duration(days: advancedDays));
    }

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      advancedNotificationId(alarm.alarmId, advancedDays),
      'Duesday',
      'D-$advancedDays ${alarm.title}', // 알림 제목
      tz.TZDateTime.from(
          scheduledTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: "item x",
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

  static Future<void> scheduleMonthlyNotification(Alarm alarm) async {
    await offNotification(alarm.alarmId);
    if (!alarm.isOn) return;
    if (Platform.isAndroid) {
      for (final days in [0, if (alarm.bfOneDayOn) 1,
        if (alarm.bfThreeDayOn) 3, if (alarm.bfOneWeekOn) 7]) {
        await const MethodChannel('com.oyoung.duesday/alarms')
            .invokeMethod('scheduleMonthly', {
          'id': days == 0 ? alarm.alarmId.toIntUid() : advancedNotificationId(alarm.alarmId, days),
          'title': alarm.title ?? '', 'date': alarm.date,
          'hour': alarm.time!.hour, 'minute': alarm.time!.minute, 'days': days,
        });
      }
      return;
    }
    final settingDate = nextAlarmOccurrence(alarm, DateTime.now());

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      alarm.alarmId.toIntUid(), // 알림 ID를 int형으로 변환
      'Duesday',
      alarm.title, // 알림 제목
      tz.TZDateTime.from(settingDate, tz.local), // 알림 예약 시간
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: "item x",
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );

    if (alarm.bfOneDayOn) {
      await setAdvancedAlarm(alarm,settingDate,1);
    }

    if (alarm.bfThreeDayOn) {
      await setAdvancedAlarm(alarm,settingDate,3);
    }

    if (alarm.bfOneWeekOn) {
      await setAdvancedAlarm(alarm,settingDate,7);
    }
  }

  static Future<void> offNotification(String alarmId) async {
    if (Platform.isAndroid) {
      for (final id in [alarmId.toIntUid(),
        for (final days in [1, 3, 7]) advancedNotificationId(alarmId, days)]) {
        await const MethodChannel('com.oyoung.duesday/alarms')
            .invokeMethod('cancelMonthly', id);
      }
    }
    await _flutterLocalNotificationsPlugin.cancel(alarmId.toIntUid());
    for (final days in [1, 3, 7]) {
      await _flutterLocalNotificationsPlugin.cancel(advancedNotificationId(alarmId, days));
    }
  }
}

// Keep legacy positive IDs for the main notification; reminders use negative IDs.
int advancedNotificationId(String alarmId, int days) {
  var hash = 0;
  for (final unit in '$alarmId:$days'.codeUnits) {
    hash = (hash * 31 + unit) & 0x7fffffff;
  }
  return -1 - (hash & 0x7ffffffe);
}

DateTime nextAlarmOccurrence(Alarm alarm, DateTime now, {int advancedDays = 0}) {
  for (var offset = 0; ; offset++) {
    final month = DateTime(now.year, now.month + offset);
    final lastDay = DateTime(month.year, month.month + 1, 0).day;
    final day = alarm.date == -1 || alarm.date > lastDay ? lastDay : alarm.date;
    final occurrence = DateTime(month.year, month.month, day,
        alarm.time!.hour, alarm.time!.minute);
    if (occurrence.subtract(Duration(days: advancedDays)).isAfter(now)) {
      return occurrence;
    }
  }
}
