import 'package:flutter/material.dart';
import 'package:frontend/Screens/dashboard.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Username"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "Password"),
            ),
            ElevatedButton(
              onPressed: () => Get.offAll(() => Dashboard()),
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
