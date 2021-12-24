import 'package:get/get.dart';

import '../modules/book_detail/views/book_detail_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
    ),
    GetPage(
      name: _Paths.BOOK_DETAIL,
      page: () => BookDetailView(),
    ),
  ];
}
