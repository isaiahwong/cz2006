import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final CrossAxisAlignment? crossAxisAlignment;

  const CustomTile({
    Key? key,
    this.title = "",
    this.leading,
    this.trailing,
    this.child,
    this.onTap,
    this.padding,
    this.crossAxisAlignment,
  }) : super(key: key);

  Widget _row(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultWidget(widget: leading),
            SizedBox(width: 20.0),
            child ??
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: darkGrey),
                ),
          ],
        ),
        DefaultWidget(widget: trailing),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: padding ??
            EdgeInsets.only(
              left: 20.0,
              right: 10.0,
              top: 10.0,
              bottom: 10.0,
            ),
        child: _row(context),
      ),
    );
  }
}
