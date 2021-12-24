import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:interview/app/core/themes/app_sizes.dart';
import 'package:interview/app/core/themes/dark/dark_theme.dart';
import 'package:interview/app/core/themes/light/light_theme.dart';

class AppTheme {
  static InputDecoration inputDecoration({
    String? hintText,
    Color? hintColor,
    bool hasBorderSide = true,
    double radius = AppSizes.borderRadius,
    Color? backgroundColor,
  }) {
    return InputDecoration(
        filled: true,
        fillColor: backgroundColor ?? Get.theme.inputDecorationTheme.fillColor,
        contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
        hintText: hintText,
        errorStyle: Get.theme.textTheme.subtitle2!.copyWith(color: Get.theme.colorScheme.error),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          borderSide: hasBorderSide
              ? BorderSide(
                  color: Get.theme.hintColor,
                  width: 1.4 / 2,
                )
              : BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          borderSide: hasBorderSide
              ? BorderSide(
                  color: Get.theme.hintColor,
                  width: 1.4,
                )
              : BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          borderSide: hasBorderSide
              ? BorderSide(
                  color: Get.theme.hintColor,
                  width: 1.4,
                )
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          borderSide: hasBorderSide
              ? BorderSide(
                  color: Get.theme.hintColor,
                  width: 1.4,
                )
              : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          borderSide: hasBorderSide
              ? BorderSide(
                  color: Get.theme.hintColor,
                  width: 1.4,
                )
              : BorderSide.none,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
            borderSide: hasBorderSide
                ? BorderSide(
                    width: 1.4,
                    color: Get.theme.hintColor,
                  )
                : BorderSide.none),
        hintStyle: Get.theme.textTheme.subtitle2!.copyWith(color: hintColor ?? Get.theme.hintColor));
  }

  static ButtonStyle primaryButtonStyle({Color? primary, Color? onPrimary}) => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
        primary: primary ?? Get.theme.primaryColor,
        elevation: 0,
        onPrimary: onPrimary ?? Colors.white.withOpacity(0.1),
      );

  // Portrait Mode Only
  void setupPortraitMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // Portrait + Landscape Mode
  void setupDefaultMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}

/*
* Here CustomColors for AppTheme (because ThemeData didn't support more custom attribute)
* with the switch of Dark/Light Mode
* */
extension Customs on ThemeData {
  Color get cDividerColor => Get.isDarkMode ? DarkTheme().dividerColor : LightTheme().dividerColor;
}
