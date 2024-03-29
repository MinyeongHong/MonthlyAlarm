import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/provider/alarm_list_viewmodel.dart';
import 'package:monthly_alarm_app/ui/setting_screen.dart';

import '../../app_theme.dart';

class PopupMenu extends ConsumerWidget {
  int? selectedMenu;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(22.0),
        ),
      ),
      elevation: 20,
      color: Theme.of(context).cardColor,
      icon: Icon(
        CupertinoIcons.bars,color: Theme.of(context).appBarTheme.iconTheme!.color,
      ),
      onSelected: (int item) {
        if (ref.watch(menuModeProvider(item)) == 1) {
          ref.read(editModeProvider.notifier).update((state) => state = !state);
        } else if (ref.watch(menuModeProvider(item)) == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingScreen()));
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 1,
          child: Text(tr('Edit')),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text(tr('Settings')),
        ),
      ],
    );
  }
}
