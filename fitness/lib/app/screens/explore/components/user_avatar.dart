import 'package:fitness/repo/social/social.dart';
import 'package:flutter/material.dart';

/// Used at user friends and workout
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
