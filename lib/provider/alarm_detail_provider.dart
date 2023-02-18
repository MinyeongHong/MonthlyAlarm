import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/repository/alarm_repository.dart';

import '../data/alarm.dart';
import '../ui/add_alarm.dart';

final alarmDetailProvider = StateNotifierProvider<AlarmDetailViewModel, Alarm>(
        (ref) => AlarmDetailViewModel());

class AlarmDetailViewModel extends StateNotifier<Alarm> {
  AlarmDetailViewModel()
      : super(Alarm(
      alarmId: '', createdAt: DateTime.now(), date: DateTime.now().day));

  AlarmDate? dateType;

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

  void selectTime(TimeOfDay newTime) {
    state = state.copyWith(time: newTime);
  }

  void saveText([String title = 'title', String content = 'content']) {
    state = state.copyWith(title: title, content: content);
  }

  void saveAlarm() {
    AlarmRepository().create(state);
  }
}
