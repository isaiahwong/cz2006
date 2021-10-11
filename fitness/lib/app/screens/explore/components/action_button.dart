import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Action button used in user avatar
class ActionButton extends StatelessWidget {
  final Color? color;
  final String? label;

  /// Choose icon for action
  final IconData icon;
  final Function action;

  ActionButton(
    this.action,
    this.icon, {
    this.color = primaryColor,
    this.label = "",
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.dialog(
          Container(
            alignment: Alignment.center,
            height: 20,
            width: 20,
            child: CircularProgressIndicator(color: primaryColor),
          ),
          useSafeArea: false,
          barrierDismissible: false,
        );
        await action();
        Get.back();
      },
      child: Icon(
        icon,
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
        color: Colors.white54,
      ),
      child: IconButton(
        onPressed: onPressed,
        color: Get.theme.primaryColor,
        icon: Icon(Icons.keyboard_arrow_right_outlined),
      ),
    );
  }
}
