import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  //bright theme
  static const white = Color(0xFFFFFFFF);
  static const defaultBlack = Color(0xFF343434);
  static const defaultGrey = Color(0xFFC7C7CC);

  static const lightGrey = Color(0xFFE8E9EB);
  static const cancelGrey = Color(0xFF8E8E93);
  static const disableGrey = Color(0xFFA7A7A7);
  static const selectedGrey = Color(0xFFF2F2F7);

  static const backgroundBlue = Color(0xFFF6F7F8);
  static const contentBlue = Color(0xFFF8FAFC);
  static const defaultBlue = Color(0xFF62ACF5);
  static const accentBlue = Color(0xFF007AFF);
  static const transParentBlue = Color(0xFFE8F0F8);

  static const title1 = TextStyle(
    fontFamily: 'AppleSDGothicNeo',
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: AppTheme.defaultBlack,
  );

  static const body1 = TextStyle(
    fontFamily: 'AppleSDGothicNeo',
    fontWeight: FontWeight.w400,
    fontSize: 17,
    color: AppTheme.defaultBlack,
  );

  static const sub1 = TextStyle(
    fontFamily: 'AppleSDGothicNeo',
    fontWeight: FontWeight.w400,
    fontSize: 13,
    color: AppTheme.defaultBlack,
  );

  static const sub2 = TextStyle(
    fontFamily: 'AppleSDGothicNeo',
    fontWeight: FontWeight.w300,
    fontSize: 10,
    color: AppTheme.defaultBlack,
  );
}
