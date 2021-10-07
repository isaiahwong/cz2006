import 'package:fitness/app/screens/explore/components/components.dart';
import 'package:fitness/app/screens/explore/components/user_avatar.dart';
import 'package:fitness/app/screens/explore/search_result_screen.dart';
import 'package:fitness/app/screens/explore/controller/social_controller.dart';
import 'package:fitness/repo/social/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/user_card.dart';

/// Social Screen - Friends and Requets
class SocialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialController>(
      init: SocialController(),
      builder: (_) => Container(
        height: Get.height,
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Get.theme.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Get.theme.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: searchIcon(),
                suffix: clearMethod(),
                hintText: "Find Users",
                labelStyle: Get.textTheme.bodyText2!.copyWith(
                  color: Get.theme.primaryColor,
                ),
                labelText: "Find Users",
                contentPadding: EdgeInsets.only(left: 20, right: 20),
              ),
              controller: _.searchTextController,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: _.searchText,
              style: Get.textTheme.bodyText1,
            ),
            Expanded(
              child: Builder(builder: (context) {
                if (_.foundUsers.length > 0) {
                  /// Parse a list of widgets
                  /// Show potential users
                  List<UserCard> _userAvatars = [];
                  for (var i = 0; i < _.foundUsers.length; i++) {
                    /// Convert User to userSnippet
                    var _userSnippet = _.foundUsers[i];

                    /// Create actions, send friend request
                    var sendAction =
                        ActionButton(() => _.sendRequest(_userSnippet.id));

                    /// Add UserAvatar Widget into List<Widget>
                    _userAvatars.add(UserCard(_userSnippet, [sendAction]));
                  }
                  return SearchResultScreen(_userAvatars);
                }
                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 10),
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
      onTap: () {
        SocialController.to.clearText();
        FocusScope.of(Get.context!).requestFocus(FocusNode());
      },
      child: Icon(Icons.clear),
    );
  }

  Icon searchIcon() {
    return Icon(
      Icons.search_outlined,
      color: Get.theme.primaryColor,
    );
  }

  /// Display pending friend requests
  Widget requestsWidget(SocialController _) {
    if (_.requests.length == 0) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 100,
        child: Text("Current no friends "),
      );
    }
    return Container();
  }

  /// Display user with basic information
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
          var user = _.friends[index];
          return UserAvatar(name: user.name, profileImage: user.profilePicture);
        },
      ),
    );
  }
}
