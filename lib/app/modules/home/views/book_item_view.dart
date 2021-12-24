import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/app/core/themes/app_sizes.dart';
import 'package:interview/app/data/models/book.dart';
import 'package:interview/app/routes/app_pages.dart';
import 'package:interview/app/shared/shared_on_tap.dart';

class BookItemView extends StatelessWidget {
  const BookItemView({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Get.theme.shadowColor,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius)
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Expanded(
                flex: 80,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.file(
                    File(book.imageDir!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                  flex: 20,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (book.name?.isNotEmpty ?? false)
                          AutoSizeText(
                            book.name!,
                            style: Get.textTheme.headline4?.copyWith(color: Colors.black),
                          ),
                        if (book.author?.isNotEmpty ?? false)
                          AutoSizeText(
                            book.author!,
                            style: Get.textTheme.subtitle1?.copyWith(color: Get.theme.hintColor),
                          ),
                      ],
                    ),
                  ))
            ],
          ),
          SharedOnTap(
            onTap: () => Get.toNamed(Routes.BOOK_DETAIL, arguments: book.id),
          )
        ],
      ),
    );
  }
}
