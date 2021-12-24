import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/app/core/themes/dark/dark_theme.dart';
import 'package:interview/app/core/themes/light/light_theme.dart';
import 'package:interview/app/core/translation/messages.dart';
import 'package:interview/app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      //translationsKeys: AppTranslation.translations,
      translations: Messages(),
      locale: Get.deviceLocale,
      // in case the locale of the device not exist in the app
      fallbackLocale: Locale('en', 'US'),
      themeMode: ThemeMode.system,
      theme: LightTheme().themeData,
      darkTheme: DarkTheme().themeData,
      title: "Books",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
