import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:monthly_alarm_app/usecase/load_alarms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/alarm.dart';
import '../repository/local_notification.dart';
import '../usecase/delete_alarm.dart';
import '../usecase/read_alarm.dart';
import '../usecase/update_alarm.dart';

part 'alarm_list_viewmodel.g.dart';

final editModeProvider = StateProvider<bool>((ref) => false);

@riverpod
int menuMode(MenuModeRef ref,int? item) {
  return item ?? 0;
}

@riverpod
class AlarmListViewModel extends _$AlarmListViewModel {
  AlarmListViewModel() : super();

  List<Alarm>? initList;

  bool isEditMode = false;

  LoadAlarms loadAlarms = GetIt.I.get();
  ReadAlarm readAlarm = GetIt.I.get();
  DeleteAlarm deleteAlarm = GetIt.I.get();
  UpdateAlarm updateAlarm = GetIt.I.get();

  @override
  List<Alarm> build() {
    return [];
  }

  void changeMode() {
    isEditMode = !isEditMode;
  }

  Future<Alarm?> load(String id) async {
    return await readAlarm.call(id);
  }

  Future<void> loadAll() async {
    state = await loadAlarms.call();
  }

  Future<void> toggle(String id, bool val) async {
    state = [
      for (final e in state) e.alarmId == id ? e.copyWith(isOn: val) : e
    ];
    await updateAlarm.call(state.firstWhere((e) => e.alarmId == id));

    if (val) {
      await LocalNotificationRepository.scheduleMonthlyNotification(state.firstWhere((e) => e.alarmId == id));
    } else {
      await LocalNotificationRepository.offNotification(id);
    }

  }

  Future<void> delete(String id) async {
    state = [
      for (final e in state)
        if (e.alarmId != id) e,
    ];

    await LocalNotificationRepository.offNotification(id);
    await deleteAlarm.call(id);
  }
}