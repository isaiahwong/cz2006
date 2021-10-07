import 'dart:ui';

import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Custom pop up

void customPopUp(String title, Widget icon) async {
  Future.delayed(Duration(seconds: 1)).then((value) => Get.back());
  await Get.dialog(
    CustomDialog(title, icon),
    barrierDismissible: true,
  );
}

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget icon;
  CustomDialog(this.title, this.icon);
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Container(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Container(
            height: Get.width * 0.4,
            width: Get.width * 0.4,
            decoration: BoxDecoration(
                color: grey.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headline4!
                        .copyWith(color: Get.theme.primaryColor)),
                SizedBox(height: 10),
                successIcon(Get.theme.primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Returns success icon
final successIcon = (Color color) {
  return Icon(Icons.check_circle_outline, color: color);
};

/// Remove icon
final removeIcon = (Color color) {
  return Icon(Icons.check_circle_outline, color: color);
};
