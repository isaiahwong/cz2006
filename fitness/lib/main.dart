import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/screens/exercise/exercise_controller.dart';
import 'package:fitness/repo/exercise/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/app/controllers/controllers.dart';
import 'package:fitness/app/theme/theme.dart';

import 'app/components/panel/sliding_panel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();

  UserRepo userRepo = UserRepo();
  AuthRepo authRepo = AuthRepo(userRepo: userRepo);
  ExerciseRepo exerciseRepo = ExerciseRepo();

  Get.put<AuthController>(AuthController(authRepo: authRepo));
  Get.put<UserController>(UserController(userRepo: userRepo));
  Get.put<ExerciseController>(ExerciseController(exerciseRepo: exerciseRepo));
  Get.put<SlidingPanelController>(SlidingPanelController());

  Get.put<UserRepo>(userRepo);
  Get.put<AuthRepo>(authRepo);
  Get.put<ExerciseRepo>(exerciseRepo);

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, widget) => Container(
        color: lightGrey,
        child: widget!,
      ),
      theme: theme(context),
      title: "SoFit",
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
    );
  }
}
