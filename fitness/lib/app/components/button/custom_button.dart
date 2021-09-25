import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final double? radius;
  final Border? border;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;

  CustomButton(
    this.title, {
    this.onPressed,
    this.height,
    this.width,
    this.radius,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.borderColor,
    this.backgroundColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: height ?? 40.0,
        width: width ?? 60.0,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius ?? 10),
          border: border,
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: textColor ?? primaryColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
          ),
        ),
      ),
    );
  }
}
