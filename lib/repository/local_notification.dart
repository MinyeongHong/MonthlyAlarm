import 'package:flutter/material.dart';
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

  static void requestPermission() {
    _flutterLocalNotificationsPlugin
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
    final scheduledTime = settingDate.subtract(Duration(days: advancedDays)); // 알림 예

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      alarm.alarmId.toIntUid(), // 알림 ID를 int형으로 변환
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
    var alarmDate = alarm.date;
    var alarmTime = TimeOfDay.fromDateTime(alarm.time!);

    final now = DateTime.now();

    final lastDayOfMonth =
        DateTime(now.year, now.month + 1, 0).day; // 이번 달의 마지막 날짜

    final scheduledDayOfMonth = (alarmDate == -1) || (alarmDate > lastDayOfMonth)
         ? lastDayOfMonth
         : alarmDate;

    var settingDate = DateTime(now.year,now.month,scheduledDayOfMonth,alarmTime.hour,alarmTime.minute);

    if(settingDate.isBefore(DateTime.now())){
      settingDate = DateTime(now.year,now.month+1,scheduledDayOfMonth,alarmTime.hour,alarmTime.minute);
    }else{
      settingDate = DateTime(now.year,now.month,scheduledDayOfMonth,alarmTime.hour,alarmTime.minute);
    }

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
    await _flutterLocalNotificationsPlugin.cancel(alarmId.toIntUid());
  }
}
