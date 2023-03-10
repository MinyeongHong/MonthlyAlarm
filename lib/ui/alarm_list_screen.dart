import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monthly_alarm_app/repository/alarm_repository.dart';
import 'package:monthly_alarm_app/repository/local_notification.dart';
import 'package:monthly_alarm_app/ui/add_alarm_screen.dart';
import 'package:monthly_alarm_app/ui/widget/alarm_tile.dart';
import 'package:monthly_alarm_app/ui/widget/popup_menu.dart';

import '../app_theme.dart';
import '../data/alarm.dart';
import '../provider/alarm_detail_viewmodel.dart';
import '../provider/alarm_list_viewmodel.dart';
import '../string.dart';
import 'edit_alarm_screen.dart';

class AlarmListScreen extends ConsumerWidget {
  const AlarmListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AlarmListViewModel vm = ref.read(alarmListViewModelProvider.notifier);
    List<Alarm> alarmList = ref.watch(alarmListViewModelProvider);
    vm.loadAll();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddAlarmScreen()
                ),
              );
            }),
        title: Text('Alarm',),
        actions: [
          PopupMenu(),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              ElevatedButton(
                  onPressed: () {
                    AlarmRepository().clear();
                  },
                  child: Text('hive DB 클리어')),
              ElevatedButton(
                  onPressed: () {
                    LocalNotification.requestPermission();
                    LocalNotification.sampleNotification();
                  },
                  child: Text('click for Noti')),
              Expanded(
                child: ListView.builder(
                    itemCount: alarmList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      var alarm = ref.watch(alarmListViewModelProvider)[idx];

                      return AlarmTile(
                        idx: idx,
                        onToggle: (bool val) {
                          alarm.isOn = val;
                          if(!val) {
                            LocalNotification.offNotification(alarm.alarmId);
                          }else{
                            LocalNotification.scheduleMonthlyNotification(alarm);
                          }
                        },
                        onTap: () {
                          vm.load(alarm.alarmId);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      EditAlarmScreen(alarm:alarm)));
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
