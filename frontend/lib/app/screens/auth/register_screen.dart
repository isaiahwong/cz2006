import 'package:flutter/material.dart';
import 'package:frontend/app/controllers/auth/register_controller.dart';
import 'package:frontend/app/theme/theme.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(
        builder: (state) => Container(
          padding: screenPadding,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Name",
                ),
                controller: state.nameController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "email",
                ),
                controller: state.emailController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "password",
                ),
                obscureText: true,
                controller: state.passwordController,
              ),
              ElevatedButton(
                  onPressed: () => state.register(), child: Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}
