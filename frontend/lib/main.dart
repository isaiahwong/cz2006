import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/app/routes/routes.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/app/controllers/controllers.dart';
import 'package:frontend/app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  Get.put<AuthController>(AuthController());
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, widget) => Container(
        color: Colors.white,
        child: SafeArea(child: widget!),
      ),
      theme: theme(context),
      title: "CZ2006 Project",
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
    );
  }
}
