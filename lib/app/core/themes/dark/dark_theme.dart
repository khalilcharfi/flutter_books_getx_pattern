import 'package:flutter/material.dart';
import 'package:interview/app/core/themes/app_text_theme.dart';

class DarkTheme {
  static final DarkTheme instance = DarkTheme._internal();

  DarkTheme._internal();

  factory DarkTheme() {
    return instance;
  }

  final Color primaryColor = Color(0xFF0082FF);
  final Color backgroundColor = Color(0xFF293655);
  final Color scaffoldBackgroundColor = Color(0xFF293655);
  final Color shadowColor = Color(0xFF444444).withOpacity(0.1);
  var dividerColor = Colors.black.withOpacity(0.3);

  ThemeData get themeData => ThemeData(
        primaryColor: primaryColor,
        splashColor: Colors.black.withOpacity(0.05),
        highlightColor: Colors.transparent,
        backgroundColor: backgroundColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        shadowColor: shadowColor,
        brightness: Brightness.light,
        textTheme: AppTextTheme.textTheme(),
        hintColor: Colors.black.withOpacity(0.3),
      );
}
