import 'package:fitness/app/screens/explore/social_controller.dart';
import 'package:fitness/repo/social/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Social Screen - Friends and Requets
class SocialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialController>(
      init: SocialController(),
      builder: (_) => Container(
        margin: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Friends",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            friendsWidget(_),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Requests",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget friendsWidget(SocialController _) {
    return Container(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _.friends.length,
        itemBuilder: (context, index) {
          return UserAvatar(
            UserSnippet(_.friends[index].id, _.friends[index].name, ""),
          );
        },
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final UserSnippet userSnippet;

  UserAvatar(this.userSnippet);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            minRadius: 20,
            maxRadius: 40,
            backgroundImage: NetworkImage(userSnippet.profilePicture.isNotEmpty
                ? userSnippet.profilePicture
                : "https://indianmemetemplates.com/wp-content/uploads/smug-pepe.jpg"),
          ),
          Text(
            userSnippet.name == "" ? userSnippet.name : "No one",
          ),
        ],
      ),
    );
  }
}
