import 'dart:io';

import 'package:fitness/common/common.dart';
import 'package:flutter/material.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegisterController extends GetxController {
  static RegisterController to = Get.find();
  final AuthRepo _authRepo;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ImagePicker _imagePicker = ImagePicker();
  RegisterController({required AuthRepo authRepo}) : _authRepo = authRepo;

  File? imageFile;
  DateTime selectedDate = DateTime.now();
  int _dateOfBirth = DateTime.now().millisecondsSinceEpoch;

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
      dateOfBirth: _dateOfBirth,
      localImagePath: imageFile?.path,
    );

    /// Upload image and update to user document
  }

  /// Select date of birth
  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year - 30),
        lastDate: DateTime.now());
    if (picked != null) {
      selectedDate = picked;
    }
    print(getAge(selectedDate.millisecondsSinceEpoch));
    update();
  }

  /// Returns user date of birth in day, month, year
  Map<String, String> get dateOfBirth {
    DateFormat dayFormatter = DateFormat("dd");

    return {
      "year": selectedDate.year.toString(),
      "day": dayFormatter.format(selectedDate),
      "month": selectedDate.month.toString(),
    };
  }

  /// Getters
  FileImage get getImagePath {
    return FileImage(File(imageFile!.path));
  }
}
