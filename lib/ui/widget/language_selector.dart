import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_theme.dart';
import '../../provider/setting_viewmodel.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> appLanguages = [
      'ko',
      'en',
      'es',
      'zh',
      'ja',
      'hi',
      'vi',
    ];

    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return AlertDialog(
      title: Column(
        children: [
          Text(tr('Language'), style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true, //MUST TO ADDED
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () async {
                await context.setLocale(Locale(appLanguages[index]));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appLanguages[index].toLangName(),
                      style: AppTheme.body1.apply(
                        color: context.locale.toString() ==
                                appLanguages[index]
                            ? isDark
                                ? AppTheme.defaultBlueDark
                                : AppTheme.defaultBlueLight
                            : isDark
                                ? AppTheme.defaultGreyDark2
                                : AppTheme.defaultGreyLight2,
                      ),
                    ),
                    Icon(
                      CupertinoIcons.checkmark_alt,
                      color: context.locale.toString() ==
                              appLanguages[index]
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
            );
          },
          itemCount: appLanguages.length,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                tr('Okay'),
                style: Theme.of(context).textTheme.titleLarge,
              )),
        )
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    );
  }
}

extension Lang on String {
  String toLangName() {
    switch (this) {
      case 'ko':
        return '한국어';
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'zh':
        return '中文';
      case 'ja':
        return '日本語';
      case 'hi':
        return 'हिन्दी';
      case 'vi':
        return 'Tiếng Việt';
      default:
        return '';
    }
  }
}
