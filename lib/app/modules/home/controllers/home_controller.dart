import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:interview/app/core/error/errors.dart';
import 'package:interview/app/core/loading/loading_state.dart';
import 'package:interview/app/data/repos/abstract/book_repo.dart';
import 'package:interview/app/routes/app_pages.dart';
import 'package:interview/app/services/book_service.dart';
import 'package:interview/app/shared/shared_snackbar.dart';

@injectable
class HomeController extends GetxController {
  var pageState = Rx<LoadingState>(LoadingState.loading());
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  BookService bookService;
  BookRepo bookRepo;

  StreamSubscription? pageStateSub;

  HomeController(this.bookService, this.bookRepo);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    /// listen for ERROR state for [pageState] to show message of failure in [scaffoldMessengerKey] context only
    pageStateSub = SharedSnackBar(loadingState: pageState, scaffoldMessengerKey: scaffoldMessengerKey).setupListener();

    loadBooks();
  }

  @override
  void onClose() {
    pageStateSub?.cancel();
  }

  loadBooks() async {
    pageState.value = LOADING();
    /// SIMULATION
    await Future.delayed(Duration(seconds: 2));
    final failureOrBooks = await bookRepo.getBooks();
    failureOrBooks.fold((failure) {
      /// SharedSnackBar is listing for any ERROR will make a pop up message
      pageState.value = ERROR(message: failure.toString(), type: MessageType.danger);
    }, (books) {
      bookService.books.assignAll(books);
      pageState.value = LOADED();
    });
  }

  goToAddBook() async {
    Get.toNamed(Routes.BOOK_DETAIL);
  }

  onRefresh() async {
    loadBooks();
  }
}
