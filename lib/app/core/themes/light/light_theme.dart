import 'package:flutter/material.dart';
import 'package:interview/app/core/themes/app_text_theme.dart';

class LightTheme{

  static final LightTheme instance = LightTheme._internal();

  LightTheme._internal();

  factory LightTheme() {
    return instance;
  }

  final Color primaryColor = Color(0xFF0082FF);
  final Color backgroundColor = Colors.white;
  final Color scaffoldBackgroundColor = Colors.white;
  final Color shadowColor = Color(0xFF444444).withOpacity(0.2);
  var dividerColor = Color(0xFF0082FF).withOpacity(0.1);

  /// Messages Errors States
  final Color danger = Color(0xFFFF4B6D);
  final Color success = Color(0xFF2ECC71);
  final Color warning = Color(0xFFF7B500);
  final Color info = Color(0xFF0082FF);

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