import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/screens/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => controller.logout(),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [Text("Username: ${controller.user.value!.name}")],
          ),
        ),
      ),
    );
  }
}
