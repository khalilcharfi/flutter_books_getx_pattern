import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:interview/app/core/themes/app_sizes.dart';
import 'package:interview/generated/locales.g.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  final homeController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_book.svg',
                    color: Get.theme.primaryColor,
                    width: AppSizes.splashIconSize,
                    height: AppSizes.splashIconSize,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  AutoSizeText(
                    LocaleKeys.books.tr.toUpperCase(),
                    style: Get.textTheme.headline2?.copyWith(
                      color: Get.theme.primaryColor,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(
                  bottom: 16, start: 52, end: 52),
              // width: MediaQuery.of(context).size.width * 0.65,
              height: 4,
              child: LinearProgressIndicator(
                backgroundColor: Color(0x1AFFFFFF),
                valueColor: AlwaysStoppedAnimation<Color>(Get.theme.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
