import 'package:flutter/material.dart';
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
  ThemeMode? prefsAppTheme;

  Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    prefsAppTheme = getTheme();
    return _prefsInstance;
  }

  ThemeMode getTheme(){
    String? theme = _prefsInstance!.getString(stringThemeMode);

    print('get Theme is ${theme}');

    if(theme == stringLight) return ThemeMode.light;
    else if(theme == stringDark) return ThemeMode.dark;
    return ThemeMode.system;
  }

  Future<void> setLightTheme() async {
    await _prefsInstance!.setString(stringThemeMode, stringLight);
    print('set Theme is ${_prefsInstance!.getString(stringThemeMode)}');
  }

  Future<void> setDarkTheme() async {
    await _prefsInstance!.setString(stringThemeMode, stringDark);
    print('set Theme is ${_prefsInstance!.getString(stringThemeMode)}');

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
