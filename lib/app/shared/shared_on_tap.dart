import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedOnTap extends StatelessWidget {
  SharedOnTap({
    Key? key,
    required this.onTap,
    this.isRipple = false,
    this.radius = 30.0,
    this.splashColor,
  }) : super(key: key) {
    splashColor = splashColor ?? Get.theme.primaryColor.withOpacity(0.1);
  }

  final VoidCallback onTap;
  final bool isRipple;
  final double radius;
  Color? splashColor;

  @override
  Widget build(BuildContext context) {
    if (isRipple) {
      return Positioned.fill(
        child: InkResponse(
          onTap: () => onTap(),
          //containedInkWell: false,
          splashFactory: InkRipple.splashFactory,
          radius: radius,
          splashColor: splashColor,
          highlightColor: Colors.transparent,
        ),
      );
    }

    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: InkRipple.splashFactory,
          splashColor: splashColor,
          highlightColor: Colors.transparent,
          onTap: () => onTap(),
        ),
      ),
    );
  }
}
