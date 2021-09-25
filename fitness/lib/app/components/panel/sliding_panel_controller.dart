import 'package:fitness/app/components/panel/sliding_panel_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

typedef Widget WithNavObserver(NavigatorObserver? observer);

class SlidingPanelController extends GetxController {
  static SlidingPanelController get(String tag) => Get.find(tag: tag);
  static Widget placeholder = SizedBox.shrink();

  late WithNavObserver panel;
  late SlidingPanelStatus status = SlidingPanelClosed();
  late final PanelController controller;
  String? tag;

  SlidingPanelController({
    Widget? panel,
    SlidingPanelStatus? status,
    PanelController? controller,
    this.tag,
  }) {
    this.panel = (ob) => panel == null ? placeholder : panel;
    this.status = status ?? this.status;
    this.controller = controller == null ? PanelController() : controller;
  }

  void open({bool fixed = false, required Widget panel}) {
    if (status is SlidingPanelOpened) return;
    status = fixed ? SlidingPanelFixed() : SlidingPanelOpened();
    this.panel = (obs) => panel;
    controller.open();
    update();
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
    update();
  }

  void close() {
    status = SlidingPanelClosing();
    controller.close();
    update();
  }
}
