import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/ui/add_alarm_screen.dart';
import 'package:monthly_alarm_app/ui/widget/alarm_tile.dart';
import 'package:monthly_alarm_app/ui/widget/popup_menu.dart';
import 'package:upgrader/upgrader.dart';

import '../data/alarm.dart';
import '../provider/alarm_list_viewmodel.dart';
import 'edit_alarm_screen.dart';

class AlarmListScreen extends ConsumerStatefulWidget {
  const AlarmListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AlarmListScreen> createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends ConsumerState<AlarmListScreen> {
  late final AlarmListViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = ref.read(alarmListViewModelProvider.notifier);
    vm.loadAll();
  }

  @override
  Widget build(BuildContext context) {
    List<Alarm> alarmList = ref.watch(alarmListViewModelProvider);
    var isEditMode = ref.watch(editModeProvider);
    return WillPopScope(
      onWillPop: () async {
        if (isEditMode) {
          ref.read(editModeProvider.notifier).update((state) => state = !state);
          return false;
        } else {
          return true;
        }
      },
      child: UpgradeAlert(
        upgrader: Upgrader(
          debugLogging: true,
          messages: UpgraderMessages(code: context.locale.toString()),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: isEditMode
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(editModeProvider.notifier)
                              .update((state) => state = !state);
                        },
                        child: AutoSizeText(
                          tr('Cancel'),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          maxLines: 1,
                          minFontSize: 8,
                        ),
                      ),
                    ),
                  )
                : PopupMenu(),
            title: Text(
              tr('AppName'),
            ),
            actions: [
              isEditMode
                  ? SizedBox.shrink()
                  : IconButton(
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
              child: Column(children: [
                // ElevatedButton(
                //     onPressed: () {
                //       AlarmRepository().clear();
                //     },
                //     child: Text('hive DB 클리어')),
                // ElevatedButton(
                //     onPressed: () {
                //       //LocalNotification.requestPermission();
                //       LocalNotificationRepository.sampleNotification();
                //     },
                //     child: Text('click for Noti')),
                alarmList.isEmpty
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.edit_notifications,
                              size: 160,
                              color: Theme.of(context).dividerColor,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "EmptyList".tr(),
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .hintStyle!
                                      .color),
                            ),
                          ],
                        ))
                    : Expanded(
                        child: ListView.builder(
                            itemCount: alarmList.length,
                            itemBuilder: (BuildContext ctx, int idx) {
                              var alarm =
                                  ref.watch(alarmListViewModelProvider)[idx];

                              return AnimatedSize(
                                duration: Duration(milliseconds: 400),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: AlarmTile(
                                    vm: vm,
                                    theme: Theme.of(context),
                                    idx: idx,
                                    onToggle: (bool val) {
                                      //alarm.isOn = val;
                                      vm.toggle(alarm.alarmId, val);
                                    },
                                    onTap: () {
                                      vm.load(alarm.alarmId);

                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              Duration(milliseconds: 200),
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              EditAlarmScreen(alarm: alarm),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }),
                      ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
