import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/image/image.dart';
import 'package:fitness/app/screens/auth/auth.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  Widget error(String msg) {
    return msg.isNotEmpty
        ? Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              msg,
              style: TextStyle(color: Colors.red),
            ),
          )
        : SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenController>(
      builder: (loginController) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: margin(
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                children: [
                  SizedBox(
                    child: logoIcon,
                    width: 40,
                  ),
                  Text(
                    "Login",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: black, letterSpacing: -1),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2),
                      ),
                    ),
                    controller: loginController.emailController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2),
                      ),
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: loginController.passwordController,
                  ),
                  error(loginController.error),
                  CustomButton(
                    "Login",
                    backgroundColor: primaryColor,
                    textColor: Colors.white,
                    width: double.infinity,
                    height: 55,
                    fontWeight: FontWeight.normal,
                    onPressed: () => loginController.login(),
                  ),
                  Divider(color: black),
                  GestureDetector(
                    onTap: () => Get.toNamed(RoutePaths.REGISTER),
                    child: Text(
                      "Register now",
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
