import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/screens/explore/components/components.dart';
import 'package:fitness/repo/social/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUsersScreen extends StatelessWidget {
  final List<Friend> friends;
  final String title;
  final List<Widget> widgets;
  AllUsersScreen(this.friends, this.title, {this.widgets = const []});

  final String currentUserId = UserController.get().user.value!.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                IconButton(onPressed: Get.back, icon: Icon(Icons.close)),
                Expanded(child: Text("Title")),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  UserSnippet user =
                      friends[index].initiator.id != currentUserId
                          ? friends[index].initiator
                          : friends[index].responder;
                  return UserCard(
                    user.name,
                    user.profilePicture,
                    widgets,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
