import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/repo.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final UserSnippet? user;

  const UserImage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user == null) return SizedBox.shrink();
    return Container(
      width: 20,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: user!.profilePicture.isNotEmpty
          ? CircleAvatar(
              maxRadius: 10,
              backgroundImage: NetworkImage(user!.profilePicture))
          : Center(
              child: Text(
                "${user!.name[0].toUpperCase()}",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontSize: 30,
                    ),
              ),
            ),
    );
  }
}
