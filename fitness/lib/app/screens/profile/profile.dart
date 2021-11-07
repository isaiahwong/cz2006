import 'dart:math';

import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/screens/profile/profile_controller.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => controller.logout(),
            )
          ],
        ),
        body: Container(
          padding: screenPadding.copyWith(top: 20, bottom: 20),
          margin: screenPadding.copyWith(top: 12, bottom: 12),
          // height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var _user = controller.user.value!;
                switch (index) {
                  case 1:
                    return _userAvatar(_user);
                  case 2:
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _userName(_user),
                          SizedBox(width: 10),
                          _userAge(_user)
                        ]);
                  case 3:
                    return _userHeightWeight(_user);
                  default:
                    return Container();
                }
              },
              separatorBuilder: (context, index) {
                if (index == 0) return Container();
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.3),
                  child: Divider(color: black.withOpacity(0.2), thickness: 1),
                );
              },
              itemCount: 4),
        ),
      ),
    );
  }

  // final _aboutMeTitle = Text("About me", style: Get.textTheme.headline5);
  Widget _userName(User user) {
    return Text(
      "${user.name}",
      style: Get.textTheme.headline4,
    );
  }

  Widget _userAge(User user) {
    return Text("24", style: Get.textTheme.headline4);
  }

  // Default values input
  Widget _userHeightWeight(User user) {
    Random r = Random();
    var height = -1;
    var weight = -1;

    /// Generate random height
    while (height < 160 || height > 180) {
      height = r.nextInt(180);
    }
    while (weight < 60 || weight > 100) {
      weight = r.nextInt(100);
    }
    return Column(
      children: [
        Text("${height} cm | ${weight} kg", textAlign: TextAlign.center),
        SizedBox(height: 2),
        _bmiCal(height, weight),
      ],
    );
  }

  /// calculate bmi
  Widget _bmiCal(int height, int weight) {
    // kg/m^2
    String _result = "";

    double _bmi = (weight / pow(height / 100, 2));
    print("Result: $_bmi");
    if (_bmi <= 18.5) {
      _result = "Underweight";
    } else if (_bmi > 18.5 && _bmi <= 25) {
      _result = "Normal";
    } else if (_bmi > 25 && _bmi <= 30) {
      _result = "Overweight";
    } else if (_bmi > 30) {
      _result = "Obese";
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      child: Text("BMI: ${_bmi.toPrecision(1)} " + _result,
          style: Get.textTheme.bodyText2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: grey.withOpacity(0.2)),
    );
  }

  Widget _userAvatar(User user) {
    return CircleAvatar(
      minRadius: 20,
      maxRadius: 80,
      backgroundImage: user.profilePicture.isNotEmpty
          ? NetworkImage(user.profilePicture)
          : null,
      backgroundColor: Colors.transparent,
      child: user.profilePicture.isNotEmpty ? null : Text(user.name[0]),
    );
  }
}
