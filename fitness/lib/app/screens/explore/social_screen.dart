import 'package:fitness/app/screens/explore/search_result_screen.dart';
import 'package:fitness/app/screens/explore/controller/social_controller.dart';
import 'package:fitness/repo/social/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/user_avatar.dart';

/// Social Screen - Friends and Requets
class SocialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialController>(
      init: SocialController(),
      builder: (_) => Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: TextField(
                decoration: InputDecoration(
                  prefix: searchIcon(),
                  suffix: clearMethod(),
                  hintText: "Find Users",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 8,
                  ),
                ),
                controller: _.searchTextController,
                textInputAction: TextInputAction.search,
                onSubmitted: _.searchText,
                style: Get.textTheme.bodyText1,
              ),
            ),
            Expanded(
              child: Builder(builder: (context) {
                if (_.foundUsers.length > 0) {
                  /// Parse a list of widgets
                  /// Show potential users
                  return SearchResultScreen([]);
                }
                return Column(
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Clear text
  Widget clearMethod() {
    return GestureDetector(
      onTap: SocialController.to.clearText,
      child: Icon(Icons.clear),
    );
  }

  Icon searchIcon() {
    return Icon(
      Icons.search_outlined,
      color: Get.theme.primaryColor,
    );
  }

  Widget friendsWidget(SocialController _) {
    if (_.friends.length == 0) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 100,
        child: Text("Current no friends "),
      );
    }
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
