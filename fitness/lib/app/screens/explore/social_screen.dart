import 'package:fitness/app/screens/explore/components/components.dart';
import 'package:fitness/app/screens/explore/components/user_avatar.dart';
import 'package:fitness/app/screens/explore/search_result_screen.dart';
import 'package:fitness/app/screens/explore/explore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Max requests shown in list view
final int maxRequests = 10;

/// Max friends shown in list view
final int maxFriends = 10;

/// Social Screen - Friends and Requets
class SocialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialController>(
      id: "SocialScreen",
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
                suffixIcon: clearMethod(),
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
                if (_.foundUsersLength > 0) {
                  /// Parse a list of widgets
                  /// Show potential users
                  List<UserCard> _userAvatars = [];
                  for (var i = 0; i < _.foundUsers.length; i++) {
                    /// Convert User to userSnippet
                    var _userSnippet = _.foundUsers[i];

                    /// Create actions, send friend request
                    var sendAction = ActionButton(
                      () => _.sendRequest(_userSnippet.id),
                      Icons.person_add_alt,
                    );

                    /// Add UserAvatar Widget into List<Widget>
                    _userAvatars.add(UserCard(
                      _userSnippet.name,
                      _userSnippet.profilePicture,
                      [sendAction],
                      age: _userSnippet.dateOfBirth,
                    ));
                  }
                  return SearchResultScreen(_userAvatars);
                }
                return ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  children: [
                    listViewTitle("Friends"),
                    friendsWidget(_),
                    listViewTitle("Requests"),
                    requestsWidget(_),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Align listViewTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: Get.textTheme.headline4,
        ),
      ),
    );
  }

  /// Clear text
  Widget clearMethod() {
    return IconButton(
      onPressed: () {
        FocusScope.of(Get.context!).requestFocus(FocusNode());
        SocialController.to.clearText();
      },
      icon: Icon(Icons.clear),
    );
  }

  Icon searchIcon() {
    return Icon(
      Icons.search_outlined,
      color: Get.theme.primaryColor,
    );
  }

  /// Display user with basic information
  Widget friendsWidget(SocialController _) {
    if (_.friends.length == 0) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 100,
        child: Text(
          "Current no friends",
          textAlign: TextAlign.center,
        ),
      );
    }
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.2),
      decoration: BoxDecoration(color: Colors.black26),
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: _.friends.length > maxFriends
            ? _.friends.length + 1
            : _.friends.length,
        itemBuilder: (context, index) {
          if (_.friends.length > maxFriends) {
            return ViewMore(() {
              print("View more from friend listview");
            });
          }
          var user = _.friends[index];
          return UserAvatar(name: user.name, profileImage: user.profilePicture);
        },
      ),
    );
  }

  /// Display pending friend requests
  Widget requestsWidget(SocialController _) {
    print("Number of pending requests: ${_.requests.length}");
    if (_.requests.length == 0) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 100,
        child: Text(
          "Current no requests",
          textAlign: TextAlign.center,
        ),
      );
    }
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.2),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: Colors.black12),
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: _.requests.length > maxRequests
            ? _.requests.length + 1
            : _.requests.length,
        itemBuilder: (context, index) {
          /// Return more button added
          if (_.requests.length > maxRequests) {
            return ViewMore(() {
              print("View more from request");
            });
          }
          var requestDocument = _.requests[index];
          var user = requestDocument.initiator;

          return Container(
            height: Get.height * 0.15,
            child: UserCard(
              user.name,
              user.profilePicture,
              [
                ActionButton(
                  () => _.handleResponse(
                    user.id,
                    requestDocument.id,
                    true,
                  ),
                  Icons.person_add_alt,
                ),
                ActionButton(
                  () => _.handleResponse(
                    user.id,
                    requestDocument.id,
                    false,
                  ),
                  Icons.person_remove_outlined,
                  color: Colors.red,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
