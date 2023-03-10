import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              trailing:Text(ref.watch(settingViewModelProvider()).mode.toString()),
              onTap: () async {
                await showDialog<ThemeMode?>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Consumer(
                      builder: (context, ref, child) =>Column(
                        children: [
                          Container(
                            color: ref.watch(settingViewModelProvider()).mode ==  ThemeMode.system ? Colors.greenAccent : Colors.grey,
                            child: InkWell(onTap: (){
                              ref.read(settingViewModelProvider().notifier).setSystemTheme();

                            },child: Text('시스템 모드',),),
                          ),
                          Container(
                            color: ref.watch(settingViewModelProvider()).mode ==  ThemeMode.light ? Colors.greenAccent : Colors.grey,
                            child: InkWell(onTap: (){
                              ref.read(settingViewModelProvider().notifier).setLightTheme();

                            },child: Text('라이트 모드',),),
                          ),

                          Container(
                            color: ref.watch(settingViewModelProvider()).mode ==  ThemeMode.dark ? Colors.greenAccent : Colors.grey,
                            child: InkWell(onTap: (){
                              ref.read(settingViewModelProvider().notifier).setDarkTheme();

                            },child: Text('다크 모드',),),
                          ),
                        ],
                      ),
                    ),
                    content: SizedBox.shrink(),
                  ),
                );
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
