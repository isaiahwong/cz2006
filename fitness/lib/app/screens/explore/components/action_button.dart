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
    this.color = Colors.blueAccent,
    this.label = "",
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Here");
        action();
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
