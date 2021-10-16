// @dart=2.9

import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/controllers/workout/workout_controller.dart';
import 'package:fitness/repo/cycling/coordinates_repo.dart';
import 'package:fitness/repo/exercise/repo.dart';
import 'package:fitness/repo/workout/cycling_repo.dart';
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
import 'package:grpc/grpc.dart';
import 'package:hiit_api/hiit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  final hiitClient = HIITServiceClient(ClientChannel(
    '192.168.31.109',
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  ));

  UserRepo userRepo = UserRepo();
  AuthRepo authRepo = AuthRepo(userRepo: userRepo);

  Get.put<AuthController>(AuthController(authRepo: authRepo));
  Get.put<UserController>(
    UserController(
      userRepo: userRepo,
      hiitClient: hiitClient,
      initWhenAuth: (User user) {
        WorkoutRepo workoutRepo =
            WorkoutRepo(userRepo: userRepo, hiitClient: hiitClient);
        CyclingRepo cyclingRepo = CyclingRepo(userRepo: userRepo);
        ExerciseRepo exerciseRepo = ExerciseRepo();
        SocialRepo socialRepo = SocialRepo(userRepo.id);
        CoordinatesRepo coordinateRepo = CoordinatesRepo();

        Get.put<ExerciseRepo>(exerciseRepo, permanent: true);
        Get.put<CoordinatesRepo>(coordinateRepo, permanent: true);
        Get.put<WorkoutRepo>(workoutRepo, permanent: true);
        Get.put<CyclingRepo>(cyclingRepo, permanent: true);
        Get.put<SocialRepo>(socialRepo, permanent: true);
        Get.put<WorkoutController>(
            WorkoutController(
              workoutRepo: workoutRepo,
              hiitClient: hiitClient,
            ),
            permanent: true);
      },
    ),
  );

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
