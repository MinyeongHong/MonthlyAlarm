import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monthly_alarm_app/repository/alarm_repository.dart';
import 'package:monthly_alarm_app/repository/local_notification.dart';
import 'package:monthly_alarm_app/ui/add_alarm_screen.dart';
import 'package:monthly_alarm_app/ui/widget/alarm_tile.dart';

import '../app_theme.dart';
import '../data/alarm.dart';
import '../provider/alarm_detail_provider.dart';
import '../provider/alarm_list_provider.dart';
import '../string.dart';

class AlarmListScreen extends ConsumerWidget {
  const AlarmListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AlarmListViewModel vm = ref.read(alarmListProvider.notifier);
    List<Alarm> alarmList = ref.watch(alarmListProvider);

    vm.loadAll();

    final box = Hive.box(strAppMode);
    final lightDark = box.get('mode');

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
                  builder: (_) => AddAlarmScreen(listVm: vm),
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
                CupertinoIcons.bars,
                color: AppTheme.accentBlue,
              ))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              TextButton(
                onPressed: () {
                  lightDark == 'light'
                      ? box.put('mode', 'dark')
                      : box.put('mode', 'light');
                },
                child: Text('ThemeData 바꾸기'),
              ),
              ElevatedButton(
                  onPressed: () {
                    AlarmRepository().clear();
                  },
                  child: Text('hive DB 클리어')),
              ElevatedButton(
                  onPressed: () {
                    LocalNotification.sampleNotification();
                  },
                  child: Text('click for Noti')),
              Expanded(
                child: ListView.builder(
                    itemCount: alarmList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      var alarm = ref.watch(alarmListProvider)[idx];

                      return AlarmTile(
                        idx: idx,
                        onToggle: (bool val) {
                          alarm.isOn = val;
                         // vm.toggle(alarm.alarmId, val);
                        },
                        onTap: () {
                          vm.load(alarm.alarmId);
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddAlarmScreen(listVm: vm)));
                        },
                      );
                    }),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
