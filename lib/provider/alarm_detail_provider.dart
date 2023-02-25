import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:monthly_alarm_app/repository/alarm_repository.dart';
import 'package:monthly_alarm_app/usecase/create_alarm.dart';
import 'package:monthly_alarm_app/usecase/read_alarm.dart';
import 'package:uuid/uuid.dart';

import '../data/alarm.dart';
import '../ui/add_alarm_screen.dart';
import '../usecase/update_alarm.dart';

final alarmDetailProvider =
    StateNotifierProvider.autoDispose<AlarmDetailViewModel, Alarm>(
        (ref) => AlarmDetailViewModel());

class AlarmDetailViewModel extends StateNotifier<Alarm> {
  AlarmDetailViewModel() : super(Alarm.emptyAlarm());

  AlarmDate? dateType;

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

  Future<void> saveText(
      [String title = 'title', String content = 'content']) async {
    state = state.copyWith(title: title, content: content);
  }

  Future<void> save() async {
    await createAlarm.call(state);
  }

  Future<void> update() async {
    await updateAlarm.call(state);
  }

}
