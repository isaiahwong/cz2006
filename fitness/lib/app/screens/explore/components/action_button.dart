import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Action button used in user avatar
class ActionButton extends StatelessWidget {
  final Color color = Get.theme.primaryColor;
  final String label = "label";
  final Function action;
  ActionButton(this.action, {color, label});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Here");
        action();
      },
      child: Icon(
        Icons.person_add_alt,
        color: color,
        semanticLabel: label,
      ),
    );
  }
}
