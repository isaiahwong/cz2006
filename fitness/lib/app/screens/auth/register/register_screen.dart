import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fitness/app/screens/auth/register/register_controller.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(
        builder: (registerController) => Container(
          padding: screenPadding,
          //margin: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: registerController.pickImage,
                  child: CircleAvatar(
                    minRadius: 50,
                    // backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: registerController.imageFile == null
                        ? null
                        : registerController.getImagePath,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Name",
                ),
                controller: registerController.nameController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "email",
                ),
                controller: registerController.emailController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "password",
                ),
                obscureText: true,
                controller: registerController.passwordController,
              ),
              ElevatedButton(
                  onPressed: () => registerController.register(),
                  child: Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}
