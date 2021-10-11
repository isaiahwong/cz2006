import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

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

/// See more button
/// Used on ListView
class ViewMore extends StatelessWidget {
  final Function() onPressed;
  ViewMore(this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        onPressed: onPressed,
        color: Get.theme.primaryColor,
        icon: Icon(
          Icons.unfold_more_rounded,
        ),
      ),
    );
  }
}
