import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/app/core/di/injection.dart';
import 'package:interview/app/core/loading/loading_state.dart';
import 'package:interview/app/modules/home/views/list_book_loading_view.dart';
import 'package:interview/app/modules/home/views/list_books_view.dart';
import 'package:interview/generated/locales.g.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final homeController = Get.put(getIt<HomeController>());

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: homeController.scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.books.tr,
            style: Get.textTheme.headline3?.copyWith(
              color: Colors.white,
            ),
          ),
          //centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: RefreshIndicator(
              onRefresh: () {
                return homeController.onRefresh();
              },
              child: Obx(() {
                final pageState = homeController.pageState.value;
                if (pageState is LOADING) {
                  return ListBookLoadingView();
                } else if (pageState is LOADED) {
                  return ListBooksView(
                    homeController: homeController,
                  );
                }
                return Container();
              }),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => homeController.goToAddBook(),
          backgroundColor: Get.theme.primaryColor,
        ),
      ),
    );
  }
}
