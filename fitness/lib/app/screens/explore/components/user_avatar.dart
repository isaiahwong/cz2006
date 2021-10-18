import 'package:fitness/app/components/image/image.dart';
import 'package:flutter/material.dart';

/// Minimum details shown about user
class UserAvatar extends StatelessWidget {
  UserAvatar({
    required this.name,
    required this.profileImage,
    this.size = 60,
  });
  final double size;
  final String name;
  final String profileImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileImage(
            imageProvider:
                profileImage.isNotEmpty ? NetworkImage(profileImage) : null,
            size: size,
          ),
          SizedBox(height: 4),
          Text(name),
        ],
      ),
    );
  }
}
