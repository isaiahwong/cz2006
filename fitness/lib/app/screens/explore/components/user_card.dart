import 'package:fitness/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Widget use to display users with some infomation
class ExploreUserCard extends StatelessWidget {
  final User user;
  final Widget? action;
  ExploreUserCard(this.user, this.action);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Row(
        children: [
          _profileImage(),
          _userNameAge(),
          Spacer(),
          action ?? Container(width: 0),
        ],
      ),
    );
  }

  /// Name age and workout type
  Widget _userNameAge() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          user.name,
          style: Get.theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        // TODO: Date of birth
        Text(
          "insert dob",
          style: Get.theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  CircleAvatar _profileImage() {
    return CircleAvatar(
      minRadius: 40,
      child: Image.network(user.profilePicture),
    );
  }
}

// TODO: Create action widget with function
