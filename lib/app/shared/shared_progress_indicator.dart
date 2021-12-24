import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedProgressIndicator extends StatelessWidget {
  const SharedProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Container(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Get.theme.primaryColor,
        ),
      ),
    );
  }
}
