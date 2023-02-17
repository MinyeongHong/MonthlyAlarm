import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  //bright theme
  static const white = Color(0xFFFFFFFF);
  static const defaultBlack = Color(0xFF343434);
  static const defaultGrey = Color(0xFFC7C7CC);
  static const backgroundGrey = Color(0x66F8FAFC);
  static const cancelGrey = Color(0xFF8E8E93);
  static const disableGrey = Color(0xFFA7A7A7);
  static const selectedGrey = Color(0xFFF2F2F7);
  static const blue = Color(0xFF62ACF5);
  static const transParentBlue = Color(0x1A62ACF5);

  static const title1 = TextStyle(
    fontFamily: 'AppleSDGothicNeo',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 20,
    color: Colors.black,
//  height: 32 / 21,
    decoration: TextDecoration.none,
    letterSpacing: 0,
  );

  static const body1 = TextStyle(
    fontFamily: 'AppleSDGothicNeo',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 17,
    color: Colors.black,
    decoration: TextDecoration.none,
    letterSpacing: 0,
  );
}
