import 'package:fitness/app/components/panel/panel.dart';
import 'package:fitness/app/components/panel/panel_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenPanelController extends GetxController {
  static Widget placeholder = SizedBox.shrink();

  late final FullScreenController controller;
  FullScreenStatus status = FullScreenStatusInactive();

  Widget? panelHeader;
  Widget? panel;

  FullScreenPanelController({
    this.panelHeader,
    this.panel,
    FullScreenController? controller,
  }) {
    if (this.panel == null) this.panel = placeholder;
    if (this.panelHeader == null) this.panelHeader = PanelHeader();
    this.controller = controller == null ? FullScreenController() : controller;
  }

  factory FullScreenPanelController.to() {
    return Get.find();
  }

  open() {
    status = FullScreenStatusOpened();
    controller.show();
    update();
  }
}
