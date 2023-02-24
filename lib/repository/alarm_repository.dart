import 'package:hive/hive.dart';
import 'package:monthly_alarm_app/string.dart';
import 'package:uuid/uuid.dart';

import '../data/alarm.dart';

class AlarmRepository {

  final Box<Alarm> alarmBox = Hive.box(strAlarm);

  Future<Alarm> create(Alarm newAlarm) async {
    return await alarmBox.put(newAlarm.alarmId, newAlarm).then((_) => newAlarm);
  }

  Future<void> update(Alarm newAlarm) async {
    return await alarmBox.put(newAlarm.alarmId, newAlarm);
  }

  Future<List<Alarm>> readAll() async {
    return alarmBox.values.toList();
  }

  Future<Alarm?> read(index) async {
    return alarmBox.getAt(index);
  }

  Future<void> delete(String id) async {
    await alarmBox.delete(id);
  }

  Future<void> deleteAll(List<Alarm> idList) async {
    idList.map((e) => e.alarmId);
    await alarmBox.deleteAll(idList);
  }

  Future<void> clear() async {
    await alarmBox.clear();
  }
}
