import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../app_theme.dart';
import '../repository/local_notification.dart';
import 'alarm_list_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    LocalNotificationRepository.requestPermission();
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AlarmListScreen()),
      );
    });
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomRight,
                  radius: 2.0,
                  colors: [
                    Theme.of(context).brightness == Brightness.light
                        ? const Color(0xFFF0EFF4)
                        : const Color(0xFF518BCB),
                    Theme.of(context).brightness == Brightness.light
                        ? const Color(0xFFE8F0F8)
                        : const Color(0xFF536D8A),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    const Spacer(),
                    Column(
                      children: [
                        RotationTransition(
                          turns: Tween(begin: -0.08, end: 0.08)
                              .chain(CurveTween(curve: Curves.easeInOut))
                              .animate(_animationController),
                          child: Stack(children: const [
                            FaIcon(
                              FontAwesomeIcons.solidBell,
                              size: 160,
                              color: AppTheme.accentBlueDark,
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.dollarSign,
                                size: 30,
                                color: AppTheme.white,
                              )),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Duesday',
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
