import 'package:fitness/app/components/panel/panel.dart';
import 'package:fitness/app/components/panel/panel_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenPanelController extends GetxController {
  static FullScreenPanelController get(String tag) => Get.find(tag: tag);
  static Widget placeholder = SizedBox.shrink();

  late final FullScreenController controller;
  FullScreenStatus status = FullScreenStatusInactive();

  final List<VoidCallback> fullScreenListeners = [];

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

    this.controller.addListener(_onChange);
  }

  void _onChange() {
    status = controller.isOpened
        ? FullScreenStatusOpened()
        : FullScreenStatusHidden();
    update();

    fullScreenListeners.forEach((l) => l());
  }

  void addFullScreenListener(VoidCallback onChange) {
    fullScreenListeners.add(onChange);
  }

  open() {
    status = FullScreenStatusOpened();
    controller.show();
    update();
  }

  hide() {
    status = FullScreenStatusHidden();
    controller.hide();
    update();
  }
}
