import 'package:fitness/app/components/image/image.dart';
import 'package:flutter/material.dart';

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
        ProfileImage(imageProvider: NetworkImage(profileImage), size: 80),
        // Container(
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     border: Border.all(color: Get.theme.primaryColor, width: 2),
        //   ),
        //   child: Image(image: NetworkImage(profileImage)),
        // ),
        SizedBox(height: 4),
        Text(name),
      ],
    );
  }
}
