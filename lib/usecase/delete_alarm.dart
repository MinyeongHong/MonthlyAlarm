import '../data/alarm.dart';
import '../repository/alarm_repository.dart';

class DeleteAlarm {
  final AlarmRepository repository;

  DeleteAlarm(this.repository);

  Future<void> call(String uid) async {
    await repository.delete(uid);
  }
}
