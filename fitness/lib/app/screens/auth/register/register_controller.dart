import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  static RegisterController to = Get.find();
  final AuthRepo _authRepo;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ImagePicker _imagePicker = ImagePicker();
  RegisterController({required AuthRepo authRepo}) : _authRepo = authRepo;

  File? imageFile;

  /// Pick image from gallery
  Future<void> pickImage() async {
    final pickedFiled = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxHeight: 400,
      maxWidth: 400,
    );
    print(pickedFiled!.path);
    imageFile = File(pickedFiled.path);
    update();
  }

  // User registration using email and password
  register() async {
    await _authRepo.register(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  /// Getters
  FileImage get getImagePath {
    return FileImage(File(imageFile!.path));
  }
}
