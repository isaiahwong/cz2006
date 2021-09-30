import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImage extends StatelessWidget {
  final ImageProvider? imageProvider;
  ProfileImage({this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor.withOpacity(1),
        shape: BoxShape.circle,
      ),
      constraints: BoxConstraints(maxHeight: 120),
      height: 100,
      width: 100,
      child: imageProvider == null
          ? placeholder()
          : Image(
              image: imageProvider!,
              fit: BoxFit.cover,
            ),
    );
  }

  static Widget placeholder() {
    return Container(
        color: Get.theme.primaryColor,
        child: Icon(Icons.people_rounded, color: Colors.white));
  }
}
