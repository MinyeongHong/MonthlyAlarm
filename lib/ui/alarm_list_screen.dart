import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monthly_alarm_app/repository/alarm_repository.dart';
import 'package:monthly_alarm_app/repository/local_notification.dart';
import 'package:monthly_alarm_app/ui/add_alarm_screen.dart';

import '../app_theme.dart';
import '../string.dart';

class AlarmListScreen extends StatefulWidget {
  const AlarmListScreen({Key? key}) : super(key: key);

  @override
  State<AlarmListScreen> createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box(strAppMode);
    final light_dark = box.get('mode');
    print(light_dark);
    return Scaffold(
      backgroundColor: AppTheme.backgroundBlue,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.add,
              color: AppTheme.accentBlue,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddAlarmScreen(),
                ),
              );
            }),
        title: Text(
          'Alarm',
          style: AppTheme.title1,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.map,
                color: AppTheme.accentBlue,
              ))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            TextButton(
              onPressed: () {
                light_dark == 'light'
                    ? box.put('mode', 'dark')
                    : box.put('mode', 'light');
              },
              child: Text('ThemeData 바꾸기'),
            ),
            ElevatedButton(
                onPressed: () {
                  AlarmRepository().clear();
                },
                child: Text('click for Hive')),
            ElevatedButton(
                onPressed: () {
                  LocalNotification.sampleNotification();
                },
                child: Text('click for Noti'))
          ]),
        ),
      ),
    );
  }
}
