import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/alarm.dart';
import '../repository/alarm_repository.dart';

final alarmListProvider = StateNotifierProvider((ref) => AlarmListNotifier());

class AlarmListNotifier extends StateNotifier<List<Alarm>> {
  AlarmListNotifier([List<Alarm>? initialAlarm]) : super(initialAlarm ?? []);

  void update() {
    var newData = AlarmRepository().readAll();
    state = newData;
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
