import 'package:fitness/app/components/panel/sliding_panel_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

typedef Widget WithNavObserver(NavigatorObserver? observer);

class SlidingPanelController extends GetxController {
  static Widget placeholder = SizedBox.shrink();

  late WithNavObserver panel;
  late SlidingPanelStatus status = SlidingPanelClosed();
  late final PanelController controller;

  SlidingPanelController({
    Widget? panel,
    SlidingPanelStatus? status,
    PanelController? controller,
  }) {
    this.panel = (ob) => panel == null ? placeholder : panel;
    this.status = status ?? this.status;
    this.controller = controller == null ? PanelController() : controller;
  }

  factory SlidingPanelController.to() {
    return Get.find();
  }

  void closed() {
    if (status is SlidingPanelSticky) {
      controller.open();
      return;
    }
    if (!(status is SlidingPanelClosing)) return;
    // close
    status = SlidingPanelClosed();
    panel = (_) => placeholder;
  }
}
