import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
fontWeight
* 100 Thin
200 Extra Light
300 Light
400 Regular
500 Medium
600 Semi Bold
700 Bold
800 Extra Bold
900 Ultra Bold
* */

/*
* Here Text Theme for the App
* some fontWeight can be overridden in the app by .copyWith
* */
class AppTextTheme {
  static TextTheme textTheme() {
    String fontFamily = "Product Sans";

    return TextTheme(
      headline1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 32,
        fontFamily: fontFamily,
      ),
      headline2: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 28,
        fontFamily: fontFamily,
      ),
      headline3: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        fontFamily: fontFamily,
      ),
      headline4: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        fontFamily: fontFamily,
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        fontFamily: fontFamily,
      ),
      headline6: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: fontFamily,
      ),
      button: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        fontFamily: fontFamily,
      ),
      subtitle1: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: fontFamily,
      ),
      subtitle2: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 13,
        fontFamily: fontFamily,
      ),
      bodyText1: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        fontFamily: fontFamily,
      ),
      bodyText2: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        fontFamily: fontFamily,
      ),
    );
  }
}
