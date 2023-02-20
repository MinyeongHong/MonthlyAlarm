import '../data/alarm.dart';
import '../repository/alarm_repository.dart';

class CreateAlarm {
  final AlarmRepository repository;

  CreateAlarm(this.repository );

  Future<void> call(Alarm alarm) async {
    await repository.create(alarm);
  }
}
