import 'package:flutter/material.dart';
import 'package:frontend/repo/repo.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController to = Get.find();
  final AuthRepo _authRepo;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RegisterController({required AuthRepo authRepo}) : _authRepo = authRepo;

  // User registration using email and password
  register() async {
    _authRepo.register(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
