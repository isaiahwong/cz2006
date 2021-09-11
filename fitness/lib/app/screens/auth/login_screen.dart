import 'package:flutter/material.dart';
import 'package:fitness/app/controllers/controllers.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/app/app_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (_) {
        return Scaffold(
          body: Container(
            color: Colors.white,
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
                  onPressed: () => Get.offAll(() => BaseScreen()),
                  child: Text("Login"),
                ),
                Divider(),
                GestureDetector(
                  onTap: () => Get.toNamed(RoutePaths.REGISTER),
                  child: Text("Register now"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
