import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImage extends StatelessWidget {
  final ImageProvider? imageProvider;
  final double size;
  final String name;

  ProfileImage({this.imageProvider, this.size = 100, this.name = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor.withOpacity(1),
        shape: BoxShape.circle,
      ),
      child: imageProvider == null
          ? placeholder(context)
          : CircleAvatar(backgroundImage: imageProvider),
    );
  }

  Widget placeholder(BuildContext context) {
    return Center(
      child: Text(
        "${name[0].toUpperCase()}",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
              fontSize: 30,
            ),
      ),
    );
  }
}
