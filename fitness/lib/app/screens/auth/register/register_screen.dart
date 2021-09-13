import 'package:flutter/material.dart';
<<<<<<< HEAD:fitness/lib/app/screens/auth/register_screen.dart
import 'package:fitness/app/controllers/auth/register_controller.dart';
=======
import 'package:fitness/app/screens/auth/register/register_controller.dart';
>>>>>>> da6e8687aa811191099b3ca98501c6d642735062:fitness/lib/app/screens/auth/register/register_screen.dart
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
          child: Column(
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
