import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:interview/app/core/error/errors.dart';
import 'package:interview/app/core/loading/loading_state.dart';
import 'package:interview/app/core/themes/app_theme.dart';
import 'package:interview/app/data/models/book.dart';
import 'package:interview/app/data/models/dto/book_dto.dart';
import 'package:interview/app/data/repos/abstract/book_repo.dart';
import 'package:interview/app/services/book_service.dart';
import 'package:interview/app/services/validator_service.dart';
import 'package:interview/app/shared/shared_snackbar.dart';
import 'package:interview/generated/locales.g.dart';

enum SubmitEvent {
  edit,
  add,
}

@injectable
class BookDetailController extends GetxController {
  final submitEvent = Rx<SubmitEvent>(SubmitEvent.add);
  var book = Rx<Book?>(null);
  var pageState = Rx<LoadingState>(LoadingState.loading());
  var actionState = Rx<LoadingState>(LoadingState.loading());
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  StreamSubscription? pageStateSub;
  StreamSubscription? actionStateSub;

  final nameTextController = TextEditingController();
  final authorTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  ValidatorService validatorService;
  BookService bookService;
  BookRepo bookRepo;

  String? name;
  String? author;
  String? imageDir;
  var imageFile = Rx<File?>(null);

  BookDetailController(this.bookRepo, this.validatorService, this.bookService);

  @override
  void onInit() {
    AppTheme().setupPortraitMode();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    pageStateSub = SharedSnackBar(loadingState: pageState, scaffoldMessengerKey: scaffoldMessengerKey).setupListener();
    actionStateSub = SharedSnackBar(loadingState: actionState, scaffoldMessengerKey: scaffoldMessengerKey).setupListener();
  }

  @override
  void onClose() {
    pageStateSub?.cancel();
    actionStateSub?.cancel();
    AppTheme().setupDefaultMode();
  }

  void onSetupBook(String? id) async {
    /// Here mean Add Page
    if (id == null) {
      submitEvent.value = SubmitEvent.add;
      pageState.value = LOADED();
      return;
    }

    /// Here mean Edit Page
    submitEvent.value = SubmitEvent.edit;
    final failureOrBook = await bookRepo.getBook(bookId: id);
    failureOrBook.fold((failure) {
      pageState.value = ERROR(message: failure.toString());
    }, (b) {
      book.value = b;
      nameTextController.text = b.name ?? '';
      authorTextController.text = b.author ?? '';
      if (b.imageDir != null) {
        imageFile.value = File(b.imageDir!);
        imageDir = b.imageDir;
      }
      pageState.value = LOADED();
    });
  }

  void onSubmit() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    Get.focusScope!.unfocus();
    formKey.currentState!.save();

    if (submitEvent.value == SubmitEvent.add) {
      _addBook();
    } else {
      _editBook();
    }
  }

  void _addBook() async {
    actionState.value = LOADING();
    final failureOrBook = await bookRepo.addBook(
        bookDto: BookDto(
      name: name,
      author: author,
      imageDir: imageDir,
    ));

    failureOrBook.fold((failure) {
      actionState.value = ERROR(message: failure.toString());
    }, (book) async {
      bookService.books.insert(0,book);
      //bookService.books.refresh();
      actionState.value = LOADED(message: LocaleKeys.book_added.tr, type: MessageType.success);
      await Future.delayed(Duration(seconds: 2));
      Get.back(closeOverlays: true);
    });
  }

  void _editBook() async {
    actionState.value = LOADING();
    final failureOrBook = await bookRepo.editBook(
        bookId: book.value!.id,
        bookDto: BookDto(
          name: name,
          author: author,
          imageDir: imageDir,
        ));

    failureOrBook.fold((failure) {
      actionState.value = ERROR(message: failure.toString());
    }, (book) async {
      final index = _findBookIndexById(bookId: book.id);
      if (index != -1) {
        bookService.books[index] = book;
      } else {
        bookService.books.insert(0,book);
      }
      //bookService.books.refresh();
      actionState.value = LOADED(message: LocaleKeys.book_saved.tr, type: MessageType.success);
      await Future.delayed(Duration(seconds: 2));
      Get.back(closeOverlays: true);
    });
  }

  int _findBookIndexById({required String bookId}) {
    return bookService.books.indexWhere((element) => element.id == bookId);
  }

  void onPickBookImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (pickedFile == null) return;
    imageFile.value = File(pickedFile.path);
    imageDir = pickedFile.path;
  }

  onDeleteBook() async {
    actionState.value = LOADING();
    if (book.value?.id == null) {
      actionState.value = ERROR(message: LocaleKeys.book_not_found.tr, type: MessageType.danger);
      return;
    }
    final bookId = book.value!.id;

    final failureOrIsDone = await bookRepo.deleteBook(bookId: bookId);
    failureOrIsDone.fold((failure) {
      actionState.value = ERROR(message: failure.toString());
    }, (isDone) async {
      if (isDone) {
        actionState.value = LOADED(message: LocaleKeys.book_deleted.tr, type: MessageType.success);
        final index = _findBookIndexById(bookId: bookId);
        if (index != -1) {
          bookService.books.removeAt(index);
        }
        Future.delayed(Duration(seconds: 2));
        Get.back(closeOverlays: true);
      } else {
        actionState.value = LOADED(message: LocaleKeys.book_deleted_issue.tr, type: MessageType.warning);
      }
    });
  }
}
