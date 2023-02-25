import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monthly_alarm_app/app_theme.dart';

import '../../data/alarm.dart';
import '../../provider/alarm_list_provider.dart';

class AlarmTile extends ConsumerWidget {
  final void Function(bool) onToggle;
  final void Function() onTap;
  final int idx;

  const AlarmTile(
      {Key? key,
      required this.onToggle,
      required this.idx,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref)  {
    final alarmState = ref.watch(alarmListProvider)[idx];
    final switchProvider = StateProvider((ref) => alarmState.isOn);
    final switchState = ref.watch(switchProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: onTap,
        child: Material(
          borderRadius: BorderRadius.circular(22),
          shadowColor: AppTheme.backgroundBlue,
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                width: 1,
                color: Color(0xFFFBFBFB),
              ),
              color: AppTheme.contentBlue,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(27, 28, 12, 28),
              child: Row(
                children: [
                  Text(
                    alarmState.title.toString(),
                    style: AppTheme.title1,
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        alarmState.date == -1 ? '매월 말일' : '매월 ${alarmState.date}일',
                        style: AppTheme.sub1,
                      ),
                      Text(
                        DateFormat('hh:mm').format(alarmState.time!),
                        style: AppTheme.sub2,
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    activeColor: AppTheme.defaultBlue,
                      trackColor: AppTheme.lightGrey,
                      value: switchState,
                      onChanged: (val) =>onToggle.call(val)
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
