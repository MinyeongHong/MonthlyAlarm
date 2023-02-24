import '../data/alarm.dart';
import '../repository/alarm_repository.dart';

class LoadAlarms {
  final AlarmRepository repository;

  LoadAlarms(this.repository);

  Future<List<Alarm>> call() async {
    return await repository.readAll();
  }
}
