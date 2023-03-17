import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:monthly_alarm_app/repository/setting_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/alarm.dart';

part 'setting_viewmodel.freezed.dart';
part 'setting_viewmodel.g.dart';


@riverpod
class SettingViewModel extends _$SettingViewModel {
  SettingViewModel() : super();

  final SettingRepository _repo = GetIt.I.get();

  @override
  ThemeSettings build() {
    return ThemeSettings(
      mode: _repo.prefsAppTheme ?? ThemeMode.system,
      language: AppLanguage.system,
    );
  }


  // Future<void> init() async{
  //   await _repo.init();
  //   _repo.getTheme();
  // }

 // void getTheme() {
 //   _repo.getTheme();
 //
 //   //var mode = SettingRepository().getTheme();
 //   // state = state.copyWith(mode: mode);
 //  }

  Future<void> setDarkTheme() async{
    state = state.copyWith(mode: ThemeMode.dark);
  await _repo.setDarkTheme();
  }

  Future<void> setLightTheme() async{
    state = state.copyWith(mode: ThemeMode.light);
   await  _repo.setLightTheme();
  }

  Future<void> setSystemTheme() async{
    state = state.copyWith(mode: ThemeMode.system);
    await _repo.setSystemLanguage();
  }

  void setLanguage(AppLanguage newLang) {
    state = state.copyWith(language:newLang);
  }

  void setSystemLanguage() {
    state = state.copyWith(language: AppLanguage.system);
  }

}

@freezed
class ThemeSettings with _$ThemeSettings {
  const factory ThemeSettings({ThemeMode? mode, AppLanguage? language}) = _ThemeSettings;
}

extension ThemeString on ThemeMode {
   String toStringTheme() {
     if(this == ThemeMode.system) return '시스템';
     else if(this == ThemeMode.light) return '라이트';
     else return '다크';
  }
}
