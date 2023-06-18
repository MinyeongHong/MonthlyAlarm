import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_theme.dart';
import '../../provider/setting_viewmodel.dart';

class ModeSelector extends ConsumerWidget {
  const ModeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return AlertDialog(
      title: Column(
        children: [
          Text(tr('Theme'), style:Theme.of(context).textTheme.titleMedium),
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
                  tr('System'),
                  style: Theme.of(context).textTheme.titleMedium!.apply(
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
                  tr('Light'),
                  style: Theme.of(context).textTheme.titleMedium!.apply(
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
                  tr('Dark'),
                  style: Theme.of(context).textTheme.titleMedium!.apply(
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
        ],
      ),
      actions: [Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              tr('Okay'),
              style: Theme.of(context).textTheme.titleLarge
            )),
      )],
      actionsAlignment: MainAxisAlignment.spaceAround,
    );
  }
}
