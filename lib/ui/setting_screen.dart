import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/ui/widget/setting_popup.dart';

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
          "설정",
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
            title: Text('언어 변경'),
            // trailing: Text(ref.watch(userViewModelProvider).language.toString()),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Show Alert Dialog Box"),
                  content: Column(
                    children: [
                      Text("You have raised a Alert Dialog Box"),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("Ok"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("Ok"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("Ok"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("Ok"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(),
          Consumer(builder: (context, ref, child) {
            return ListTile(
              title: Text('테마 변경'),
              trailing: Text(
                  ref.watch(settingViewModelProvider).mode!.toStringTheme(),
                  style: Theme.of(context).textTheme.bodySmall),
              onTap: () async {
                await showDialog<void>(
                    barrierColor: Colors.black26,
                    context: context,
                    builder: (context) => SettingModePopUp());
              },
            );
          }),
          Divider(),
          ListTile(
            title: Text('서비스 이용약관'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('개인정보 이용방침'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('오픈소스 라이센스'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
