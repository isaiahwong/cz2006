import 'package:flutter/material.dart';

abstract class SlidingPanelStatus {
  const SlidingPanelStatus();
}

class SlidingPanelOpened extends SlidingPanelStatus {
  final WithNavObserver? panel;
  final bool fixed;
  const SlidingPanelOpened({this.panel, this.fixed = false});
  @override
  List<Object> get props => [panel ?? SizedBox.shrink()];
}

class SlidingPanelSticky extends SlidingPanelStatus {
  const SlidingPanelSticky();
}

class SlidingPanelFixed extends SlidingPanelStatus {
  const SlidingPanelFixed();
}

class SlidingPanelClosing extends SlidingPanelStatus {
  const SlidingPanelClosing();
}

class SlidingPanelClosed extends SlidingPanelStatus {
  const SlidingPanelClosed();
}
