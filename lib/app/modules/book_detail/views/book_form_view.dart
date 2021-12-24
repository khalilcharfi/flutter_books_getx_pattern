import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:interview/app/core/themes/app_sizes.dart';
import 'package:interview/app/core/themes/app_theme.dart';
import 'package:interview/app/modules/book_detail/controllers/book_detail_controller.dart';
import 'package:interview/app/shared/shared_image_scale_animation.dart';
import 'package:interview/generated/locales.g.dart';

class BookFormView extends StatefulWidget {
  const BookFormView({
    Key? key,
    required this.bookDetailController,
  }) : super(key: key);

  @override
  State<BookFormView> createState() => _BookFormViewState();

  final BookDetailController bookDetailController;
}

class _BookFormViewState extends State<BookFormView> {
  late FocusNode _nameFocusNode;
  late FocusNode _authorFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _authorFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _authorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.bookDetailController.formKey,
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    shadowColor: Get.theme.shadowColor,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Stack(
                      children: [
                        Obx(() {
                          final imageFile = widget.bookDetailController.imageFile.value;
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Get.theme.primaryColor.withOpacity(0.1),
                            child: imageFile != null
                                ? SharedImageScaleAnimation(
                                  child: Image.file(
                              imageFile,
                              fit: BoxFit.cover,
                            ),
                                )
                                : Container(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/images/ic_book.svg',
                                color: Colors.white,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          );
                        }),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashFactory: InkRipple.splashFactory,
                              splashColor: Get.theme.primaryColor.withOpacity(0.1),
                              highlightColor: Colors.transparent,
                              onTap: () => widget.bookDetailController.onPickBookImage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment(0.95, 0.95),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => widget.bookDetailController.onPickBookImage(),
                      child: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/images/ic_edit.svg',
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: _nameFocusNode,
                    controller: widget.bookDetailController.nameTextController,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_authorFocusNode);
                    },
                    validator: widget.bookDetailController.validatorService.validateName,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (value) {
                      widget.bookDetailController.name = value;
                    },
                    style: Get.theme.textTheme.subtitle2!.copyWith(color: Colors.black),
                    decoration: AppTheme.inputDecoration(hasBorderSide: false, hintText: LocaleKeys.name.tr),

                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: _authorFocusNode,
                    controller: widget.bookDetailController.authorTextController,
                    onFieldSubmitted: (_) {
                      widget.bookDetailController.onSubmit();
                    },
                    validator: widget.bookDetailController.validatorService.validateName,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (value) {
                      widget.bookDetailController.author = value;
                    },
                    style: Get.theme.textTheme.subtitle2!.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        //fillColor: Get.theme.backgroundColor,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadius,
                            ),
                            borderSide: BorderSide.none),
                        hintText: LocaleKeys.author.tr,
                        hintStyle: Get.theme.textTheme.subtitle2!.copyWith(color: Get.theme.hintColor)),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      style: AppTheme.primaryButtonStyle(),
                      onPressed: () => widget.bookDetailController.onSubmit(),
                      child: AutoSizeText(
                        LocaleKeys.save.tr,
                        style: Get.textTheme.headline4!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          fontFamily: "Product Sans",
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
