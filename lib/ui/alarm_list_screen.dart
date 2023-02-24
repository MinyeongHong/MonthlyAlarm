import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monthly_alarm_app/repository/alarm_repository.dart';
import 'package:monthly_alarm_app/repository/local_notification.dart';
import 'package:monthly_alarm_app/ui/add_alarm_screen.dart';

import '../app_theme.dart';
import '../data/alarm.dart';
import '../provider/alarm_list_provider.dart';
import '../string.dart';

class AlarmListScreen extends ConsumerWidget {
  const AlarmListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    AlarmListViewModel vm = ref.read(alarmListProvider.notifier);
    vm.loadAll();
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
                  builder: (_) => AddAlarmScreen(listVm:vm),
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
                child: Text('하이브 클리어')),
            ElevatedButton(
                onPressed: () {
                 vm.loadAll();
                },
                child: Text('refresh list')),

            ElevatedButton(
                onPressed: () {
                  LocalNotification.sampleNotification();
                },
                child: Text('click for Noti')),
            Expanded(
              child: ListView.builder(
                  itemCount: vm.state.length,
                  itemBuilder: (BuildContext ctx, int idx) {
                    print(vm.state.length);
                    var alarm = vm.state[idx];
                    print(alarm);
                    return Container(
                      child: Column(
                        children: [
                          Text(alarm.alarmId),
                          Text(alarm.date.toString()),
                          Text(alarm.title.toString()),
                          Text(alarm.time.toString()),
                        ],
                      ),
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}

