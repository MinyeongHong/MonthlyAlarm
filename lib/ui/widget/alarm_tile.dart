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
  final ThemeData theme;

  const AlarmTile({
    Key? key,
    required this.onToggle,
    required this.idx,
    required this.onTap,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmState = ref.watch(alarmListViewModelProvider)[idx];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: onTap,
        child: theme.brightness == Brightness.dark
            ? DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: alarmState.isOn
                      ? const [
                          BoxShadow(
                            color: Color(0xFF414F5E), // 그림자 색상
                            spreadRadius: 1.0, // 그림자 크기
                            blurRadius: 3.0, // 흐림 정도
                            offset: Offset(2, 2), // 그림자 위치
                          )
                        ]
                      : const [
                          BoxShadow(color: Color(0xFF414F5E)),
                          BoxShadow(
                            color: AppTheme.backgroundBlueDark,
                            spreadRadius: 1.0, // 그림자 크기
                            blurRadius: 3.0, // 흐림 정도
                            offset: Offset(2, 2), // 그림자 위치
                          ),
                        ],
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: alarmState.isOn
                          ? AppTheme.lightBlueDark
                          : AppTheme.transparent),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(27, 28, 12, 28),
                    child: Row(
                      children: [
                        if (ref.watch(editModeProvider))
                          DecoratedBox(
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
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
                                    ? AppTheme.defaultTextDark
                                    : AppTheme.disabledDark2),
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
                                      ? AppTheme.defaultTextDark
                                      : AppTheme.disabledDark2),
                            ),
                            Text(
                              DateFormat.Hm().format(alarmState.time!),
                              style: AppTheme.sub2.apply(
                                  color: alarmState.isOn
                                      ? AppTheme.defaultTextDark
                                      : AppTheme.disabledDark2),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Visibility(
                          visible: !ref.watch(editModeProvider),
                          child: CupertinoSwitch(
                            activeColor: AppTheme.defaultBlueDark,
                            value: alarmState.isOn,
                            onChanged: (val) => onToggle.call(val),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
            : DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: alarmState.isOn
                      ? const [
                          BoxShadow(
                            color: AppTheme.defaultGreyDark2, // 그림자 색상
                            spreadRadius: 1.0, // 그림자 크기
                            blurRadius: 3.0, // 흐림 정도
                            offset: Offset(2, 2), // 그림자 위치
                          )
                        ]
                      : const [
                          BoxShadow(color: AppTheme.defaultGreyLight1),
                          BoxShadow(
                              color: Color(0xFFF2F3F3),
                              spreadRadius: -1.0,
                              blurRadius: 3.0,
                              offset: Offset(2, 2)),
                        ],
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: alarmState.isOn
                          ? AppTheme.lightBlueLight
                          : AppTheme.transparent),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(27, 28, 12, 28),
                    child: Row(
                      children: [
                        if (ref.watch(editModeProvider))
                          DecoratedBox(
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
                                    ? AppTheme.defaultTextLight
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
