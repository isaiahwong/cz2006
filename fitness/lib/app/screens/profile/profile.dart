import 'package:flutter/material.dart';
import 'package:fitness/app/screens/auth/auth.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => Get.offAll(() => LoginScreen()),
          )
        ],
      ),
      body: Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}
