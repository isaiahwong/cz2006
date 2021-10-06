// @dart=2.9

import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/repo/exercise/repo.dart';
import 'package:fitness/repo/workout/workout.dart';
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
  AuthRepo authRepo = AuthRepo(
    userRepo: userRepo,
    initWhenAuth: () {
      WorkoutRepo workoutRepo = WorkoutRepo(userRepo: userRepo);
      ExerciseRepo exerciseRepo = ExerciseRepo();
      SocialRepo socialRepo = SocialRepo(userRepo.id);

      Get.put<ExerciseRepo>(exerciseRepo, permanent: true);
      Get.put<WorkoutRepo>(workoutRepo, permanent: true);
      Get.put<SocialRepo>(socialRepo, permanent: true);
    },
  );

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
      builder: (context, widget) => widget,
      theme: theme(context),
      title: "SoFit",
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
    );
  }
}
