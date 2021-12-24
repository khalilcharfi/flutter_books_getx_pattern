import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:interview/app/core/di/injection.dart';
import 'package:interview/app/data/models/book.dart';
import 'package:interview/app/routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() async {
    super.onInit();
    WidgetsFlutterBinding.ensureInitialized();
    await configureDependencies();
    await _initHive();
    /// in reality we should add a timeout
    /// in case there is a lot to pre load inits before go to HOME (like Firebase,Ads,..etc)

    /// Simulation of waiting
    await Future.delayed(Duration(seconds: 2));
    Get.offNamed(Routes.HOME);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> _initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BookAdapter());
  }
}
