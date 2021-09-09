import 'package:fitness/app/components/panel/sliding_panel_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

typedef Widget WithNavObserver(NavigatorObserver? observer);

class SlidingPanelController extends GetxController {
  static Widget placeholder = SizedBox.shrink();

  WithNavObserver panel;
  SlidingPanelStatus status = SlidingPanelClosed();
  late final PanelController controller;

  SlidingPanelController({
    required this.panel,
    required this.status,
    PanelController? controller,
  }) {
    this.controller = controller == null ? PanelController() : controller;
  }

  factory SlidingPanelController.to() {
    return Get.find();
  }
}
