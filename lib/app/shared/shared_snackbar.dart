import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/app/core/error/errors.dart';
import 'package:interview/app/core/loading/loading_state.dart';
import 'package:interview/app/core/themes/app_sizes.dart';
import 'package:interview/app/core/themes/light/light_theme.dart';

class SharedSnackBar {
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Rx<LoadingState?>? loadingState;
  MessageType? messageType;
  String? message;

  SharedSnackBar({
    this.scaffoldMessengerKey,
    this.loadingState,
  });

  int i = 0;

  StreamSubscription setupListener() {
    StreamSubscription loadingSub = loadingState!.listen((value) {
      // ERROR
      if (value is ERROR) {
        /*if (!skipDuplicatedMsg && message == value.message && messageType == value.type && DateTime.now().difference(errorShowedDateTime) <= snackbarDurationToHide) {
          return;
        }*/
        message = value.message;
        messageType = value.type;
      } else if (value is LOADED) {
        /*if (!skipDuplicatedMsg && message == value.message && messageType == value.type && DateTime.now().difference(errorShowedDateTime) <= snackbarDurationToHide) {
          return;
        }*/
        message = value.message;
        messageType = value.type;
      } else {
        return;
      }

      if (messageType != null && message != null) {
        Color color = LightTheme.instance.primaryColor;
        switch (messageType) {
          case MessageType.info:
            color = LightTheme.instance.info;
            break;
          case MessageType.danger:
            color = LightTheme.instance.danger;
            break;
          case MessageType.success:
            color = LightTheme.instance.success;
            break;
          case MessageType.warning:
            color = LightTheme.instance.warning;
            break;
          default:
            color = LightTheme.instance.primaryColor;
        }

        if (Get.isSnackbarOpen) Get.back();

        scaffoldMessengerKey?.currentState
          ?..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                message!,
                style: Get.theme.textTheme.bodyText1!.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              backgroundColor: color,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              ),
              //margin: EdgeInsets.all(16),
            ),
          );
      }
    });
    return loadingSub;
  }
}
