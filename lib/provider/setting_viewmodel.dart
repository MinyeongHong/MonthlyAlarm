import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:monthly_alarm_app/repository/setting_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    );
  }

  Future<void> setDarkTheme() async {
    state = state.copyWith(mode: ThemeMode.dark);
    await _repo.setDarkTheme();
  }

  Future<void> setLightTheme() async {
    state = state.copyWith(mode: ThemeMode.light);
    await _repo.setLightTheme();
  }

  Future<void> setSystemTheme() async {
    state = state.copyWith(mode: ThemeMode.system);
    await _repo.setSystemTheme();
  }

  // void getLanguage(BuildContext context) {
  //   var languageCode = context.locale.toString();
  //   state = state.copyWith(language: languageCode.toAppLanguage());
  // }
  //
  // Future<void> setLanguage(BuildContext context, AppLanguage newLan) async {
  //   await context.setLocale(Locale(newLan.toLangName()));
  //   state = state.copyWith(language: newLan);
  // }
}

@freezed
class ThemeSettings with _$ThemeSettings {
  const factory ThemeSettings({ThemeMode? mode}) =
      _ThemeSettings;
}

extension ThemeString on ThemeMode {
  String toStringTheme() {
    if (this == ThemeMode.system)
      return tr('System');
    else if (this == ThemeMode.light)
      return tr('Light');
    else
      return tr('Dark');
  }
}
