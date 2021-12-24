import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/app/core/di/injection.dart';
import 'package:interview/app/core/loading/loading_state.dart';
import 'package:interview/app/modules/book_detail/views/book_form_view.dart';
import 'package:interview/generated/locales.g.dart';

import '../controllers/book_detail_controller.dart';

class BookDetailView extends StatefulWidget {
  @override
  State<BookDetailView> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends State<BookDetailView> {
  /// we make tag here because this BookDetailController can be generated per page and this page can be opened multiple times for different books
  final bookDetailController = Get.put(getIt<BookDetailController>(), tag: '${UniqueKey()}');

  var isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      String? id = Get.arguments;
      bookDetailController.onSetupBook(id);
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: bookDetailController.scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Obx(() {
              final submitEvent = bookDetailController.submitEvent.value;
              if (submitEvent == SubmitEvent.edit) {
                return InkWell(
                  onTap: () => bookDetailController.onDeleteBook(),
                  child: Container(
                    width: 50,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return Container();
            }),
          ],
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
            child: Obx(() {
              final pageState = bookDetailController.pageState.value;

              if (pageState is LOADING) {
              } else if (pageState is LOADED) {
                return BookFormView(bookDetailController: bookDetailController);
              }

              return Container();
            }),
          ),
        ),
      ),
    );
  }
}
