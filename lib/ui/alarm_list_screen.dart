import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
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
    var isEditMode = ref.watch(editModeProvider);
    vm.loadAll();

    return Scaffold(
      appBar: AppBar(
        leading:  isEditMode ?  Center(
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: GestureDetector(
              onTap: (){ref
                  .read(editModeProvider.notifier)
                  .update((state) => state = !state);},
              child: AutoSizeText(
                tr('Cancel'),
               style: TextStyle(color:Theme.of(context).primaryColor),
               // style: AppTheme.body2.apply(color: Theme.of(context).primaryColor),
                maxLines: 1,
                minFontSize: 8,
              ),
            ),
          ),
        ) : PopupMenu(),
        title: Text(
          tr('AppName'),
        ),
        actions: [
          isEditMode ? SizedBox.shrink() : IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => AddAlarmScreen()),
                );
              }),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              // ElevatedButton(
              //     onPressed: () {
              //       AlarmRepository().clear();
              //     },
              //     child: Text('hive DB 클리어')),
              ElevatedButton(
                  onPressed: () {
                    //LocalNotification.requestPermission();
                    LocalNotificationRepository.sampleNotification();
                  },
                  child: Text('click for Noti')),
              Expanded(
                child: ListView.builder(
                    itemCount: alarmList.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      var alarm = ref.watch(alarmListViewModelProvider)[idx];



                      return AnimatedSize(
                        duration: Duration(milliseconds: 400),
                        child: AlarmTile(
                          vm: vm,
                          theme: Theme.of(context),
                          idx: idx,
                          onToggle: (bool val) {
                            alarm.isOn = val;
                            if (!val) {
                              LocalNotificationRepository.offNotification(alarm.alarmId);
                            } else {
                              LocalNotificationRepository.scheduleMonthlyNotification(
                                  alarm);
                            }
                          },
                          onTap: () {
                            vm.load(alarm.alarmId);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        EditAlarmScreen(alarm: alarm)));
                          },
                        ),
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
