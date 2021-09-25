import 'package:fitness/app/screens/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:fitness/app/screens/auth/auth.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => controller.logout(),
            )
          ],
        ),
        body: Center(
          child: Text("Profile Screen"),
        ),
      ),
    );
  }
}
