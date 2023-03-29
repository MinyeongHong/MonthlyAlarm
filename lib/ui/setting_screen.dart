import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/ui/widget/language_selector.dart';
import 'package:monthly_alarm_app/ui/widget/mode_selector.dart';

import '../app_theme.dart';
import '../provider/setting_viewmodel.dart';

class SettingScreen extends ConsumerWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          tr('Settings'),
          //style: TextStyle(color: Colors.grey[800]),
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(tr('Language')),
             trailing: Text(context.locale.toString().toLangName(),style: Theme.of(context).textTheme.bodySmall,),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => LanguageSelector(),
              );
            },
          ),
          Divider(),
          Consumer(builder: (context, ref, child) {
            return ListTile(
              title: Text(tr('Theme')),
              trailing: Text(
                  ref.watch(settingViewModelProvider).mode!.toStringTheme(),
                  style: Theme.of(context).textTheme.bodySmall),
              onTap: () async {
                await showDialog<void>(
                    barrierColor: Colors.black26,
                    context: context,
                    builder: (context) =>
                        ModeSelector());
              },
            );
          }),
          // Divider(),
          // ListTile(
          //   title: Text(tr('ServiceTerms')),
          //   onTap: () {},
          // ),
          // Divider(),
          // ListTile(
          //   title: Text(tr('PrivacyPolicy')),
          //   onTap: () {},
          // ),
          Divider(),
          ListTile(
            title: Text(tr('OpenSourceLicenses')),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => LicensePage()));
            },
          ),
        ],
      ),
    );
  }
}
