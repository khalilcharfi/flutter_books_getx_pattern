import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/app/core/themes/app_sizes.dart';
import 'package:interview/app/modules/home/views/book_item_view.dart';
import 'package:interview/app/modules/home/controllers/home_controller.dart';

class ListBooksView extends StatelessWidget {
  const ListBooksView({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final books = homeController.bookService.books.toList();
      return GridView.builder(
        padding: EdgeInsets.only(bottom: 80),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: AppSizes.gridMaxCrossAxisExtent,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 1/1.6,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return BookItemView(book:book);
        },
      );
    });
  }
}
