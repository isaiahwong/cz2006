import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/image/image.dart';
import 'package:flutter/material.dart';
import 'package:fitness/app/screens/auth/register/register_controller.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:get/get.dart';
import 'package:fitness/app/routes/routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(
        builder: (registerController) => Container(
          color: Colors.white,
          padding: EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(top: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: margin(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
              children: [
                // Container(
                //   padding: EdgeInsets.all(8),
                //   child: GestureDetector(
                //     onTap: registerController.pickImage,
                //     child: ProfileImage(
                //       imageProvider: registerController.imageFile == null
                //           ? null
                //           : FileImage(registerController.imageFile!),
                //     ),
                //   ),
                // ),
                SizedBox(
                  child: logoIcon,
                  width: 40,
                ),
                Text(
                  "Register",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: black, letterSpacing: -1),
                ),
                // dateOfBirth(registerController),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                  controller: registerController.nameController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                  controller: registerController.emailController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                  obscureText: true,
                  enableSuggestions: false,
                  controller: registerController.passwordController,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        "Date of birth:",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )),
                dateOfBirth(registerController),
                CustomButton(
                  "Register",
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  width: double.infinity,
                  height: 55,
                  fontWeight: FontWeight.normal,
                  onPressed: () => registerController.register(),
                ),
                Divider(color: black),
                GestureDetector(
                  onTap: () => Get.toNamed(RoutePaths.LOGIN),
                  child: Text(
                    "If you are already a member, Login now",
                  ),
                ),
              ],
            ),
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
        border: Border.all(width: 2, color: grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
