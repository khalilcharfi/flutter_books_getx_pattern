import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/app/core/themes/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class ListBookLoadingView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Get.theme.primaryColor.withOpacity(0.06),
      highlightColor: Get.theme.primaryColor.withOpacity(0.15),
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 80),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: AppSizes.gridMaxCrossAxisExtent,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 1 / 1.6,
          ),
          itemCount: 30,
          itemBuilder: (context, index) => Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius)
            ),
                child: Container(
                  color: Colors.white,
                ),
              )),
    );
  }
}
