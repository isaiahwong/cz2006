import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImage extends StatelessWidget {
  final ImageProvider? imageProvider;
  final double size;
  ProfileImage({this.imageProvider, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor.withOpacity(1),
        shape: BoxShape.circle,
        border: Border.all(color: Get.theme.primaryColor, width: 4),
      ),
      child: imageProvider == null
          ? placeholder()
          : CircleAvatar(backgroundImage: imageProvider),
    );
  }

  static Widget placeholder() {
    return Container(
        color: Get.theme.primaryColor,
        child: Icon(Icons.people_rounded, color: Colors.white));
  }
}
