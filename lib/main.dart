import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/provider/alarm_list_provider.dart';
import 'package:monthly_alarm_app/provider/user_provider.dart';
import 'package:monthly_alarm_app/repository/local_notification.dart';
import 'package:monthly_alarm_app/string.dart';
import 'package:monthly_alarm_app/ui/alarm_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

import 'app_theme.dart';
import 'data/alarm.dart';
import 'di.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmAdapter());

  await Hive.openBox(strAppMode,);
  await Hive.openBox<Alarm>(strAlarm);

  await LocalNotification.initialize();
  initializeTimeZones();

  setupGetIt();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    LocalNotification.requestPermission();
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box(strAppMode).listenable(),
        builder: (context, Box box, widget) {
          final lightDark = box.get('mode', defaultValue: 'light');
          return MaterialApp(
            color: AppTheme.backgroundBlue,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
            ),
            darkTheme: lightDark == 'light'
                ? ThemeData(brightness: Brightness.light)
                : ThemeData(brightness: Brightness.dark),
            home: AlarmListScreen(),
          );
        });
  }
}
