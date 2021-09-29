import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final underlineBorderW2 = UnderlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor,
    width: 2.0,
  ),
);

final underlineBorderW3 = UnderlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor,
    width: 3.0,
  ),
);

final underlineBorderW4 = UnderlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor,
    width: 4.0,
  ),
);

final underlineBorderW5 = UnderlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor,
    width: 5.0,
  ),
);

final underlineBorderW6 = UnderlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor,
    width: 5.0,
  ),
);

final underlineBorderW8 = UnderlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor,
    width: 8.0,
  ),
);

class UnderlineTextField extends StatelessWidget {
  final String? hintText;
  final TextAlign? textAlign;

  const UnderlineTextField({
    Key? key,
    this.hintText,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.headline4,
      textAlign: textAlign ?? TextAlign.left,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: underlineBorderW2,
        enabledBorder: underlineBorderW2.copyWith(
          borderSide: BorderSide(
            color: accentColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}

class NakedTextField extends StatelessWidget {
  final String? hintText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? errorText;
  final TextAlign? textAlign;
  final double? fontSize;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final bool enableInteractiveSelection;
  final bool showCursor;

  const NakedTextField({
    Key? key,
    this.hintText,
    this.style,
    this.controller,
    this.hintStyle,
    this.textAlign,
    this.onChanged,
    this.errorText,
    this.fontSize,
    this.keyboardType,
    this.inputFormatters,
    this.showCursor = true,
    this.enableInteractiveSelection = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: style ??
          Theme.of(context).textTheme.headline3!.copyWith(fontSize: fontSize),
      textAlign: textAlign ?? TextAlign.left,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      enableInteractiveSelection: enableInteractiveSelection,
      showCursor: showCursor,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        hintStyle: hintStyle,
        errorText: errorText,
        errorStyle: Theme.of(context).textTheme.headline6!.copyWith(color: red),
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }
}
