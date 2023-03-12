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
     {Key? key,}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AlarmListScreen()),
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: UpgradeAlert(
          upgrader: Upgrader(),
          child: Scaffold(
            body:Center(
              child: Text('this is splash sceen')
            ),
          ),
        ),
      ),
    );
  }
}
