import 'package:get_it/get_it.dart';
import 'package:monthly_alarm_app/repository/alarm_repository.dart';
import 'package:monthly_alarm_app/repository/setting_repository.dart';
import 'package:monthly_alarm_app/usecase/create_alarm.dart';
import 'package:monthly_alarm_app/usecase/delete_alarm.dart';
import 'package:monthly_alarm_app/usecase/load_alarms.dart';
import 'package:monthly_alarm_app/usecase/read_alarm.dart';
import 'package:monthly_alarm_app/usecase/update_alarm.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<AlarmRepository>(AlarmRepository());
  getIt.registerSingletonAsync<SettingRepository>(
          () async {
            final setting = SettingRepository();
            await setting.init();
    return setting;
  });

  getIt.registerSingleton<CreateAlarm>(CreateAlarm(getIt.get<AlarmRepository>()));
  getIt.registerSingleton<DeleteAlarm>(DeleteAlarm(getIt.get<AlarmRepository>()));
  getIt.registerSingleton<UpdateAlarm>(UpdateAlarm(getIt.get<AlarmRepository>()));
  getIt.registerSingleton<LoadAlarms>(LoadAlarms(getIt.get<AlarmRepository>()));
  getIt.registerSingleton<ReadAlarm>(ReadAlarm(getIt.get<AlarmRepository>()));

  print('DI Complete');
}