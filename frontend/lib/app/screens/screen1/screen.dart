import 'package:flutter/material.dart';
import 'package:frontend/app/screens/screen1/push_screen.dart';
import 'package:frontend/app/controllers/controllers.dart';
import 'package:get/get.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Screen1Controller>(
      init: Screen1Controller(),
      builder: (_) {
        return Container(
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              Text("Screen 1"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => Get.to(() => SecondaryScreen()),
                  child: Text("Next screen"),
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        );
      },
    );
  }
}
