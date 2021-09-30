import 'package:fitness/app/components/image/image.dart';
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
                  child: ProfileImage(
                    imageProvider: registerController.imageFile == null
                        ? null
                        : FileImage(registerController.imageFile!),
                  ),
                ),
              ),
              dateOfBirth(registerController),
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
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// date of birth widget
  Widget dateOfBirth(RegisterController registerController) {
    Map<String, String> _dob = registerController.dateOfBirth;
    return GestureDetector(
        onTap: registerController.selectDate,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _DobWidget(value: _dob["day"]!),
            _DobWidget(value: _dob["month"]!),
            _DobWidget(value: _dob["year"]!),
          ],
        ));
  }
}

/// Widget for date of birth
class _DobWidget extends StatelessWidget {
  _DobWidget({String this.value = ""});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: grey,
        border: Border.all(width: 2, color: Get.theme.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(value, style: Get.textTheme.headline5),
    );
  }
}
