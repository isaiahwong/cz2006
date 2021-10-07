import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Minimum details shown about user
class UserAvatar extends StatelessWidget {
  UserAvatar({
    required this.name,
    required this.profileImage,
  });
  final String name;
  final String profileImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Get.theme.primaryColor, width: 2),
          ),
          child: Image(image: NetworkImage(profileImage)),
        ),
        Text(name),
      ],
    );
  }
}
