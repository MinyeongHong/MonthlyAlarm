import 'package:get_it/get_it.dart';
import 'package:monthly_alarm_app/usecase/load_alarms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/alarm.dart';
import '../repository/local_notification.dart';
import '../usecase/read_alarm.dart';

part 'alarm_list_viewmodel.g.dart';

@riverpod
class AlarmListViewModel extends _$AlarmListViewModel {
  AlarmListViewModel() : super();

  List<Alarm>? initList;

  LoadAlarms loadAlarms = GetIt.I.get();
  ReadAlarm readAlarm = GetIt.I.get();

  @override
  List<Alarm> build() {
    return [];
  }

  Future<Alarm?> load(String id) async {
    return await readAlarm.call(id);
  }

  Future<void> loadAll() async {
    state = await loadAlarms.call();
  }

  void toggle(String id, bool val) {
    state = [
      for (final e in state) e.alarmId == id ? e.copyWith(isOn: val) : e
    ];
  }

  void delete(String id) {
    state = [
      for (final e in state)
        if (e.alarmId != id) e,
    ];

    LocalNotification.offNotification(id);
  }
}