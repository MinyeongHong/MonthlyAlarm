import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monthly_alarm_app/provider/setting_viewmodel.dart';
import 'package:monthly_alarm_app/repository/local_notification.dart';
import 'package:monthly_alarm_app/string.dart';
import 'package:monthly_alarm_app/ui/splash_screen.dart';
import 'package:timezone/data/latest.dart';
import 'package:upgrader/upgrader.dart';

import 'app_theme.dart';
import 'data/alarm.dart';
import 'di.dart';

Future<void> initSetting() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmAdapter());
  await Hive.openBox<Alarm>(stringAlarm);
  setupGetIt();
  await LocalNotification.initialize();
  await Upgrader().initialize();
  initializeTimeZones();
}

void main() async {
  await initSetting();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(settingViewModelProvider).mode,
      home: SplashScreen(),
    );
  }
}
