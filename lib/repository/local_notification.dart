import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../data/alarm.dart';

class LocalNotification {
  LocalNotification._();

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("mipmap/ic_launcher");

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

  static Future<void> sampleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails("channel id", "channel name",
            channelDescription: "channel description",
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(
        badgeNumber: 1,
      ),
    );

    await _flutterLocalNotificationsPlugin.show(
        0, "plain title", "plain body", platformChannelSpecifics,
        payload: "item x");
  }

  static Future<void> scheduleMonthlyNotification(Alarm alarm) async {
    var alarmDate = alarm.date;
    var alarmTime = TimeOfDay.fromDateTime(alarm.time!);

    final now = DateTime.now();
    final lastDayOfMonth =
        DateTime(now.year, now.month + 1, 0).day; // ?????? ?????? ????????? ??????
    final scheduledDayOfMonth = alarmDate <= lastDayOfMonth
        ? alarmDate
        : lastDayOfMonth; // ?????? ?????? ???????????? ?????? ?????? ?????? ????????? ????????? ??????

    final scheduledTime = DateTime(now.year, now.month, scheduledDayOfMonth,
        alarmTime.hour, alarmTime.minute); // ?????? ?????? ??????

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails("channel id", "channel name",
            channelDescription: "channel description",
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(
        badgeNumber: 1,
      ),
    );

    tz.TZDateTime scheduledDaily(Time alarmTime) {
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduledDate = tz.TZDateTime(
          tz.local, now.year, now.month, now.day, alarmTime.hour, alarmTime.minute);
      scheduledDate = scheduledDate.add(const Duration(days: 1));
      return scheduledDate;
    }

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      alarm.alarmId.toIntUid(), // ?????? ID??? int????????? ??????
      alarm.title, // ?????? ??????
      alarm.content, // ?????? ??????
      tz.TZDateTime.from(scheduledTime, tz.local), // ?????? ?????? ??????
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: "item x",
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

  static Future<void> offNotification(String alarmId) async {
    await _flutterLocalNotificationsPlugin.cancel(alarmId.toIntUid());
  }
}
