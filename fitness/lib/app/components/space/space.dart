import 'package:flutter/material.dart';

List<Widget> padding(List<Widget> list, EdgeInsets padding) {
  return list
      .map(
        (c) => Container(
          padding: padding,
          child: c,
        ),
      )
      .toList();
}

List<Widget> margin(
    {required List<Widget> children, required EdgeInsets margin}) {
  return children
      .map(
        (c) => Container(
          margin: margin,
          child: c,
        ),
      )
      .toList();
}
