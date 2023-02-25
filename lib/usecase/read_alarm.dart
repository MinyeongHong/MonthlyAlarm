import 'package:monthly_alarm_app/data/alarm.dart';

import '../repository/alarm_repository.dart';

class ReadAlarm {
  final AlarmRepository repository;

  ReadAlarm(this.repository);

  Future<Alarm?> call(String id) async {
    return await repository.readById(id);
  }
}
