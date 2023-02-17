import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monthly_alarm_app/repository/alarm_repository.dart';
import 'package:monthly_alarm_app/repository/local_notification.dart';
import 'package:monthly_alarm_app/ui/add_alarm.dart';

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
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.add),onPressed:(){Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>  AddAlarmScreen(),
          ),
        );
        }),
        title: Text('Alarm'),
        actions: [IconButton(onPressed: (){}, icon:Icon(CupertinoIcons.map))],
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
            ElevatedButton(onPressed: (){
              AlarmRepository().clear();
              print(AlarmRepository().readAll().length);

            }, child: Text('click for Hive')),
            ElevatedButton(onPressed: (){
             LocalNotification.sampleNotification();

            }, child: Text('click for Noti'))
          ]),
        ),
      ),
    );
  }
}
