import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monthly_alarm_app/provider/setting_viewmodel.dart';
import 'package:monthly_alarm_app/ui/alarm_list_screen.dart';
import 'package:timezone/data/latest.dart';
import 'package:upgrader/upgrader.dart';

import '../data/alarm.dart';
import '../di.dart';
import '../repository/local_notification.dart';
import '../repository/setting_repository.dart';
import '../string.dart';

class SplashScreen extends ConsumerStatefulWidget {
  SplashScreen(
     {
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  Future<void> initSetting() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AlarmAdapter());
    await Hive.openBox<Alarm>(stringAlarm);
    setupGetIt();
    await LocalNotification.initialize();
    await Upgrader().initialize();
    initializeTimeZones();
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ref.read(settingViewModelProvider.notifier).init();

    // Timer(const Duration(milliseconds: 2500), () {
    //   // if (true) {
    //   //   exit(0);
    //   // } else {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => AlarmListScreen()));
    //   // }
    // });

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: UpgradeAlert(
          upgrader: Upgrader(),
          child: Scaffold(
            backgroundColor: Colors.indigo,
            body: Center(child: InkWell(onTap: (){  Navigator.push(
                context, MaterialPageRoute(builder: (context) => AlarmListScreen()));}, child: FlutterLogo())),
          ),
        ),
      ),
    );
  }
}
