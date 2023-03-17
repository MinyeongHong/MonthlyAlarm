import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_theme.dart';
import '../../provider/setting_viewmodel.dart';

class SettingModePopUp extends ConsumerWidget {
  const SettingModePopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 7),
      title: Column(
        children: [
          Text('테마 설정', style:Theme.of(context).textTheme.titleMedium),
          SizedBox(
            height: 35,
          ),
          InkWell(
            onTap: () async {
              await ref.read(settingViewModelProvider.notifier).setSystemTheme();
            },
            child: Row(
              children: [
                Text(
                  '시스템 모드',
                  style: AppTheme.body1.apply(
                    color: ref.watch(settingViewModelProvider).mode ==
                            ThemeMode.system
                        ? isDark
                            ? AppTheme.defaultBlueDark
                            : AppTheme.defaultBlueLight
                        : isDark
                            ? AppTheme.defaultGreyDark2
                            : AppTheme.defaultGreyLight2,
                  ),
                ),
                Spacer(),
                Icon(
                  CupertinoIcons.checkmark_alt,
                  color: ref.watch(settingViewModelProvider).mode ==
                          ThemeMode.system
                      ? isDark
                          ? AppTheme.defaultBlueDark
                          : AppTheme.defaultBlueLight
                      : isDark
                          ? AppTheme.defaultGreyDark1
                          : AppTheme.defaultGreyLight1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () async {
             await ref.read(settingViewModelProvider.notifier).setLightTheme();
            },
            child: Row(
              children: [
                Text(
                  '라이트 모드',
                  style: AppTheme.body1.apply(
                    color: ref.watch(settingViewModelProvider).mode ==
                            ThemeMode.light
                        ? isDark
                            ? AppTheme.defaultBlueDark
                            : AppTheme.defaultBlueLight
                        : isDark
                            ? AppTheme.defaultGreyDark2
                            : AppTheme.defaultGreyLight2,
                  ),
                ),
                Spacer(),
                Icon(
                  CupertinoIcons.checkmark_alt,
                  color: ref.watch(settingViewModelProvider).mode ==
                          ThemeMode.light
                      ? isDark
                          ? AppTheme.defaultBlueDark
                          : AppTheme.defaultBlueLight
                      : isDark
                          ? AppTheme.defaultGreyDark1
                          : AppTheme.defaultGreyLight1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () async {
              await ref.read(settingViewModelProvider.notifier).setDarkTheme();
            },
            child: Row(
              children: [
                Text(
                  '다크 모드',
                  style: AppTheme.title2.apply(
                    color: ref.watch(settingViewModelProvider).mode ==
                            ThemeMode.dark
                        ? isDark
                            ? AppTheme.defaultBlueDark
                            : AppTheme.defaultBlueLight
                        : isDark
                            ? AppTheme.defaultGreyDark2
                            : AppTheme.defaultGreyLight2,
                  ),
                ),
                Spacer(),
                Icon(
                  CupertinoIcons.checkmark_alt,
                  color: ref.watch(settingViewModelProvider).mode ==
                          ThemeMode.dark
                      ? isDark
                          ? AppTheme.defaultBlueDark
                          : AppTheme.defaultBlueLight
                      : isDark
                          ? AppTheme.defaultGreyDark1
                          : AppTheme.defaultGreyLight1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: InkWell(onTap: () {Navigator.pop(context);}, child: Text('완료',style: Theme.of(context).textTheme.titleMedium,)),
          )
        ],
      ),
      content: SizedBox.shrink(),
    );
  }
}
