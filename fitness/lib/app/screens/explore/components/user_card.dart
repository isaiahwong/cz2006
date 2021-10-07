import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/common/common.dart';

import 'package:fitness/repo/user/user.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// Used at user friends and workout
class UserCard extends StatelessWidget {
  final User user;
  final List<Widget> actionWidgets;
  UserCard(this.user, this.actionWidgets);

  @override
  Widget build(BuildContext context) {
    print(user.profilePicture);
    print("Username: ${user.name}");
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              minRadius: 20,
              maxRadius: 40,
              backgroundImage: NetworkImage(user.profilePicture.isNotEmpty
                  ? user.profilePicture
                  : "https://indianmemetemplates.com/wp-content/uploads/smug-pepe.jpg"),
            ),
            SizedBox(width: 8),
            Text(
              user.name.isNotEmpty
                  ? user.name + ", " + getAge(user.dateOfBirth).toString()
                  : "Unknown",
              style: Get.textTheme.headline3!.copyWith(color: darkGrey),
            ),
            Spacer(),
            actions(),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Widget actions() => Column(children: actionWidgets);
}
