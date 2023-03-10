import 'package:hive/hive.dart';
import 'package:monthly_alarm_app/data/user.dart';
import 'package:monthly_alarm_app/string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../data/alarm.dart';

class SettingRepository {
  static Future<SharedPreferences> get _instance async {
    _prefsInstance ??= await SharedPreferences.getInstance();
    return _prefsInstance!;
  }

  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  Future<void> setLightTheme() async {
    _prefsInstance!.setString(stringThemeMode, stringLight);
  }

  Future<void> setDarkTheme() async {
    _prefsInstance!.setString(stringThemeMode, stringDark);
  }

  Future<void> setSystemTheme() async {
    _prefsInstance!.remove(stringThemeMode); //TODO
   // _prefsInstance.setString(stringThemeMode, null);
  }

  Future<void> setSystemLanguage() async {
    _prefsInstance!.remove(stringLanguage); //TODO
  }

  Future<void> setLanguage(AppLanguage lang) async {
     _prefsInstance!.setString(stringLanguage, lang.toString()); //TODO
  }


}
