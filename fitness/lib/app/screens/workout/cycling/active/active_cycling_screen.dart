import 'package:fitness/app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ActiveCyclingScreen extends GetView<CyclingDetailsController> {
  Container _mapboxUI(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GetBuilder<CyclingDetailsController>(
            builder: (_) => Container(
              height: 200,
              child: MapBoxNavigationView(
                options: controller.mapboxOptions,
                onCreated: (MapBoxNavigationViewController mapboxController) =>
                    {
                  controller.setMapBoxController(mapboxController),
                  Navigator.pop(context),
                  controller.startNavigation()
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _mapboxUI(context),
      ],
    );
  }
}
