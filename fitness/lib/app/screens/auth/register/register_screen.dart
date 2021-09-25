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
        builder: (registerControler) => Container(
          padding: screenPadding,
          //margin: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Name",
                ),
                controller: registerControler.nameController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "email",
                ),
                controller: registerControler.emailController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "password",
                ),
                obscureText: true,
                controller: registerControler.passwordController,
              ),
              ElevatedButton(
                  onPressed: () => registerControler.register(),
                  child: Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}
