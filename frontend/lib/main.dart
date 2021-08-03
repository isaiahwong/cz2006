import 'package:flutter/material.dart';
import 'package:frontend/screens/screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "CZ2006 Project",
      debugShowCheckedModeBanner: true,
      home: SplashScreen(),
    );
  }
}
