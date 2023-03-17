import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:monthly_alarm_app/usecase/load_alarms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/alarm.dart';
import '../repository/local_notification.dart';
import '../usecase/delete_alarm.dart';
import '../usecase/read_alarm.dart';

part 'alarm_list_viewmodel.g.dart';

final editModeProvider = StateProvider<bool>((ref) => false);
//final menuProvider = Provider<int>((ref) => 0);
// @riverpod
// bool editMode(EditModeRef ref) {
//   bool isEditMode = ref.state;
//   print('new state ${ref.state}');
//
//   return isEditMode;
//
// }

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

  void toggle(String id, bool val) {
    state = [
      for (final e in state) e.alarmId == id ? e.copyWith(isOn: val) : e
    ];
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