
import '../data/alarm.dart';
import '../repository/alarm_repository.dart';

class UpdateAlarm {
  final AlarmRepository repository;

  UpdateAlarm(this.repository);

  Future<void> call(Alarm alarm) async {
    await repository.update(alarm);
  }
}
