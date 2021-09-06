import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/app/controllers/controllers.dart';
import 'package:fitness/app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();

  UserRepo userRepo = UserRepo();
  AuthRepo authRepo = AuthRepo(userRepo: userRepo);

  Get.put<AuthController>(AuthController(authRepo: authRepo));
  Get.put<UserController>(UserController(userRepo: userRepo));
  Get.put<UserRepo>(userRepo);
  Get.put<AuthRepo>(authRepo);

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
