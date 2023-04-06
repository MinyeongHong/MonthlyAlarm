import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:monthly_alarm_app/usecase/create_alarm.dart';
import 'package:monthly_alarm_app/usecase/delete_alarm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/alarm.dart';
import '../repository/local_notification.dart';
import '../usecase/update_alarm.dart';

part 'alarm_detail_viewmodel.g.dart';

@riverpod
class AlarmDetailViewModel extends _$AlarmDetailViewModel {

  @override
  Alarm build([Alarm? initVal]) {
    return initVal ?? Alarm.emptyAlarm();
  }

  AlarmDate get dateType {
    return state.date.parseType();
  }

  CreateAlarm createAlarm = GetIt.I.get();
  UpdateAlarm updateAlarm = GetIt.I.get();

  dayBeforeOneDayOn() {
    state = state.copyWith(bfOneDayOn: !state.bfOneDayOn);
  }

  dayBeforeThreeDayOn() {
    state = state.copyWith(bfThreeDayOn: !state.bfThreeDayOn);
  }

  dayBeforeOneWeekOn() {
    state = state.copyWith(bfOneWeekOn: !state.bfOneWeekOn);
  }

  void selectDate(int newDate) {
    state = state.copyWith(date: newDate);
  }

  void selectTime(DateTime newTime) {
    state = state.copyWith(time: newTime);
  }

  void toggleTime() {
    var preTime = state.time;

    if (preTime!.hour > 12) {
      state = state.copyWith(time: preTime.subtract(Duration(hours: 12)));
    } else {
      state = state.copyWith(time: preTime.add(Duration(hours: 12)));
    }
  }

  Future<void> save(String title, String content) async {
    if(title.isEmpty) title = tr("NewAlarm");
    state = state.copyWith(title: title, content: content);

    await createAlarm.call(state);
    await LocalNotificationRepository.scheduleMonthlyNotification(state);
  }

  Future<void> update(String title, String content) async {
    if(title != state.title) state = state.copyWith(title: title);
    if(content != state.content) state = state.copyWith(content: content);

    await LocalNotificationRepository.offNotification(state.alarmId);

    await updateAlarm.call(state);
    await LocalNotificationRepository.scheduleMonthlyNotification(state);
  }
}

extension TypeParsing on int {
  AlarmDate parseType() {
    if (this == 1)
      return AlarmDate.first;
    else if (this == -1)
      return AlarmDate.last;
    else
      return AlarmDate.custom;
  }
}
