import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monthly_alarm_app/provider/setting_viewmodel.dart';
import 'package:monthly_alarm_app/repository/local_notification.dart';
import 'package:monthly_alarm_app/string.dart';
import 'package:monthly_alarm_app/ui/splash_screen.dart';
import 'package:timezone/data/latest.dart';

import 'app_theme.dart';
import 'data/alarm.dart';
import 'di.dart';

Future<void> initSetting() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmAdapter());
  await Hive.openBox<Alarm>(stringAlarm);
  setupGetIt();
  await getIt.allReady();
  initializeTimeZones();
  await LocalNotificationRepository.initialize();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initSetting();

  runApp(
    EasyLocalization(
      saveLocale: true,
      useOnlyLangCode: true,
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
        Locale('es'),
        Locale('ja'),
        Locale('zh'),
        Locale('vi'),
        Locale('hi')
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(settingViewModelProvider).mode,
      home: SplashScreen(),
    );
  }
}
