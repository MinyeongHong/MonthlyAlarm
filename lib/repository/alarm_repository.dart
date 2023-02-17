import 'package:hive/hive.dart';
import 'package:monthly_alarm_app/string.dart';

import '../data/alarm.dart';

class AlarmRepository {
  final Box<Alarm> alarmBox = Hive.box(strAlarm);

  create(Alarm newAlarm) {
    alarmBox.put(newAlarm.alarmId, newAlarm);
  }

  List<Alarm> readAll() {
    return alarmBox.values.toList();
  }

  Alarm? read(index) {
    return alarmBox.getAt(index);
  }

  delete(String id) {
    alarmBox.delete(id);
  }

  deleteAll(List<Alarm> idList) {
    idList.map((e) => e.alarmId);
    alarmBox.deleteAll(idList);
  }

  clear() {
    alarmBox.clear();
  }
}
