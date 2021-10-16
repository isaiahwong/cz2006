import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/controller.dart';

class ExploreWorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreWorkoutController>(
      builder: (_) {
        return Container(
          child: ListView.builder(
            itemCount: _.getPublicWorkoutLength,
            itemBuilder: (contex, index) {
              return Text("Index: ${index}");
            },
          ),
        );
      },
    );
  }
}
