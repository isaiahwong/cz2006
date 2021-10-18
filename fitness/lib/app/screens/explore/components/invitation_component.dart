import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Use for invitation
class InvitationComponent extends StatelessWidget {
  final String creatorName;
  final List<Widget> actionWidgets;
  InvitationComponent(this.creatorName, this.actionWidgets);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: Get.width,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: Get.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("${creatorName} sent u an invite"),
            SizedBox(width: 8),
            ...actionWidgets,
            SizedBox(width: 8)
          ],
        ),
      ),
    );
  }
}
