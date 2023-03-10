import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monthly_alarm_app/app_theme.dart';

import '../../provider/alarm_list_viewmodel.dart';

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
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmState = ref.watch(alarmListViewModelProvider)[idx];
 //   final userState = ref.watch(userViewModelProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: onTap,
        child: Material(
          borderRadius: BorderRadius.circular(22),
        //  shadowColor: AppTheme.backgroundBlueLight,
          elevation:true
          //userState.themeMode == AppThemeMode.light
              ? 5 : 0,
          child: Container(
            decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      width: 1,
                      color: Color(0xFFFBFBFB),
                    ),
                    color: alarmState.isOn
                        ? AppTheme.lightBlueLight
                        : AppTheme.disabledBlueLight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(27, 28, 12, 28),
              child: Row(
                children: [
                  if (ref.watch(editModeProvider))
                    Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Checkbox(
                          onChanged: (bool? value) {},
                          value: true,
                        )),
                  Expanded(
                    child: Text(
                      alarmState.title.toString(),
                      maxLines: null,
                      style: AppTheme.title2.apply(
                          color: alarmState.isOn
                              ?AppTheme.defaultTextLight
                              : AppTheme.disabledLight2),
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        alarmState.date == -1
                            ? '매월 말일'
                            : '매월 ${alarmState.date}일',
                        style: AppTheme.sub1.apply(
                            color: alarmState.isOn
                                ? AppTheme.defaultTextLight
                                : AppTheme.disabledLight2),
                      ),
                      Text(
                        DateFormat.Hm().format(alarmState.time!),
                        style: AppTheme.sub2.apply(
                            color: alarmState.isOn
                                ? AppTheme.defaultTextLight
                                : AppTheme.disabledLight2),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Visibility(
                    visible: !ref.watch(editModeProvider),
                    child: CupertinoSwitch(
                        activeColor: AppTheme.defaultBlueLight,
                        // trackColor: userState.themeMode == AppThemeMode.light
                        //     ? AppTheme.lightGrey
                        //     : AppTheme.selectedNavy,
                        value: alarmState.isOn,
                        onChanged: (val) => onToggle.call(val)),
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
