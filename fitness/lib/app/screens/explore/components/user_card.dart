import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/common/common.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// Used at user friends and workout
class UserCard extends StatelessWidget {
  final String username;
  final String profilePic;
  final int? age;
  final List<Widget> actionWidgets;
  UserCard(this.username, this.profilePic, this.actionWidgets, {this.age});

  @override
  Widget build(BuildContext context) {
    String ageString = "";
    if (age != null) {
      ageString = ", " + getAge(age!).toString();
    }
    print("Username: $username");
    print("Is profileimage blank: ${profilePic.isEmpty}");
    return Container(
      height: 100,
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                minRadius: 20,
                maxRadius: 30,
                backgroundImage:
                    profilePic.isNotEmpty ? NetworkImage(profilePic) : null,
                backgroundColor: primaryColor,
                child: Text(username[0]),
              ),
              SizedBox(width: 8),
              Text(
                username.isNotEmpty ? username + ageString : "Unknown",
                style: Get.textTheme.headline3!.copyWith(color: darkGrey),
              ),
              Spacer(),
              actions(),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget actions() => Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: actionWidgets);
}
