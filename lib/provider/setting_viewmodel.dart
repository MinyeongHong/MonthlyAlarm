import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/user.dart';

part 'setting_viewmodel.freezed.dart';
part 'setting_viewmodel.g.dart';

//final themeProvider = StateNotifierProvider((ref) => SettingViewModel());

@riverpod
class SettingViewModel extends _$SettingViewModel {

  @override
  ThemeSettings build([ThemeSettings? setting]) {
    return setting ?? ThemeSettings(
      mode: ThemeMode.system,
      language: AppLanguage.system,
    );
  }
  // void toggle() {
  //   state = state.copyWith(mode: state.mode!.toggle);
  // }

  void setDarkTheme() {
    state = state.copyWith(mode: ThemeMode.dark);
  }
  void setLightTheme() {
    state = state.copyWith(mode: ThemeMode.light);
  }
  void setSystemTheme() {
    state = state.copyWith(mode: ThemeMode.system);
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

// extension ToggleTheme on ThemeMode {
//   ThemeMode get toggle {
//     switch (this){
//       case ThemeMode.dark:
//         return ThemeMode.light;
//       case ThemeMode.light:
//         return ThemeMode.dark;
//       case ThemeMode.system:
//         return ThemeMode.system;
//     }
//   }
// }

// @Riverpod(keepAlive:true)
// class UserViewModel extends _$UserViewModel {
//   late SharedPreferences preferences;
//
//   User user = User();
//
//   Future<void> init() async {
//     preferences = await SharedPreferences.getInstance();
//   }
//
//   Future<void> setThemeMode(AppThemeMode mode) async {
//     if(mode == AppThemeMode.light){
//       preferences = await SharedPreferences.getInstance();
//       preferences.setString(stringThemeMode, stringLight);
//       state = state.copyWith(themeMode: AppThemeMode.light);
//     }
//     else{
//       preferences = await SharedPreferences.getInstance();
//       preferences.setString(stringThemeMode, stringDark);
//       state = state.copyWith(themeMode: AppThemeMode.dark);
//       print('setting compl');
//       print(state.themeMode);
//     }
//   }
//
//   @override
//   User build() {
//     return user;
//   }
// }
