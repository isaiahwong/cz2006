import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final screenPadding = EdgeInsets.only(left: 12, right: 12);
final componentPadding = EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8);

final borderRadius = BorderRadius.only(
    topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0));

final allBorderRadius = borderRadius.copyWith(
  topLeft: Radius.circular(18.0),
  topRight: Radius.circular(18.0),
  bottomLeft: Radius.circular(18.0),
  bottomRight: Radius.circular(18.0),
);

final boxDecorationRadius = BoxDecoration(
  color: Colors.white,
  borderRadius: borderRadius,
);

const primaryColor = Color(0xFF3E50FF);
const accentColor = Color(0xFF7B86FF);

const orange = Color(0xFFFF834B);
const black = Color(0xFF262626);
const green = Color(0xFF1DBB99);
const grey = Color(0xFFE4E4E4);
final darkGrey = Colors.grey[700];
final lightGrey = Colors.grey[50];
const red = Color(0xFFFB5566);
const googleBlue = Color(0xFF397EE7);

final theme = (BuildContext context) => ThemeData(
      fontFamily: "Lato",
      textTheme:
          GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
        bodyText1: TextStyle(
          fontSize: 16.0,
          color: primaryColor,
        ),
        headline2: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        headline1: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        headline3: TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        headline4: TextStyle(
          fontSize: 23.0,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        headline5: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        headline6: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        bodyText2: TextStyle(
          fontSize: 16.0,
          color: primaryColor,
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      primaryColor: primaryColor,
      accentColor: accentColor,
      scaffoldBackgroundColor: lightGrey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
