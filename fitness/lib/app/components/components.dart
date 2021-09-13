import 'package:flutter/material.dart';
export 'tile/tile.dart';
export 'card/card.dart';
export 'space/space.dart';
export 'button/button.dart';
export 'textfield/textfield.dart';
export 'number/number.dart';

/// Helper class to handle null widgets declaratively
class DefaultWidget extends StatelessWidget {
  final Widget? widget;
  final Widget? defaultWidget;

  const DefaultWidget({Key? key, this.widget, this.defaultWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return widget ?? defaultWidget ?? SizedBox.shrink();
  }
}
