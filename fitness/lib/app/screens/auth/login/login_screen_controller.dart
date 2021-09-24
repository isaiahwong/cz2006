import 'package:flutter/material.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  static LoginScreenController to = Get.find();

  final AuthRepo _authRepo;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String error = "";

  LoginScreenController({required AuthRepo authRepo}) : _authRepo = authRepo;

  String _validate() {
    if (emailController.text.isEmpty) return "Please fill in email.";
    if (!emailController.text.isEmail) return "Please enter valid email.";
    if (passwordController.text.isEmpty) return "Please fill in password.";
    return "";
  }

  // User registration using email and password
  void login() async {
    error = _validate();

    if (error.isNotEmpty) {
      update();
      return;
    }

    try {
      await _authRepo.signin(
        email: emailController.text,
        password: passwordController.text,
      );
      return;
    } catch (e) {
      error = "Password or email is incorrect.";
    }
    update();
  }
}
