import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:monthly_alarm_app/usecase/load_alarms.dart';

import '../data/alarm.dart';
import '../repository/alarm_repository.dart';

final alarmListProvider = StateNotifierProvider((ref) => AlarmListViewModel());

class AlarmListViewModel extends StateNotifier<List<Alarm>> {
  AlarmListViewModel([List<Alarm>? initialAlarm]) : super(initialAlarm ?? []);

  LoadAlarms loadAlarms = GetIt.I.get();

  void update() {
  }

  Future<void> loadAll() async {
    state = await loadAlarms.call();
    print(state.length);
  }

  void delete(String id) {
    state = [
      for (final e in state)
        if (e.alarmId != id) e,
    ];
  }

}

// class AlarmProvider with ChangeNotifier{
//   final List<Alarm> _alarmList = [];
//   List<Alarm> get alarmList => _alarmList;
//
//   void getAlarmList(){
//
//   }
//
//   void addAlarm(Alarm newAlarm){
//     //add Alarm
//     _alarmList.add(newAlarm);
//     notifyListeners();
//   }
//
//   void deleteAlarm(String alarmId){
//
//
//     _alarmList.removeWhere((element) => element.alarmId == alarmId);
//     notifyListeners();
//   }
// }
