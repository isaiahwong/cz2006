import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/screens/workout/camera/pose.dart';
import 'package:get/get.dart';

class RoutePaths {
  static const ROOT = '/';
  static const LOGIN = '/auth/login';

  static const REGISTER = '/auth/register';
  static const APP = '/app';
  static const WORKOUT_ACTIVE = '/workout/active';
  static const WORKOUT_DETAILS = '/workout/details';
}

class Routes {
  static final routes = [
    GetPage(name: RoutePaths.ROOT, page: () => SplashScreen()),
    GetPage(
        name: RoutePaths.LOGIN,
        page: () => LoginScreen(),
        binding: LoginBindings()),
    GetPage(
        name: RoutePaths.REGISTER,
        page: () => RegisterScreen(),
        binding: RegisterUserBindings()),
    GetPage(
      name: RoutePaths.APP,
      page: () => AppScreen(),
      binding: AppScreenBindings(),
    ),
    GetPage(
      name: RoutePaths.WORKOUT_ACTIVE,
      page: () => P2PVideo(),
    ),
    GetPage(
      name: RoutePaths.WORKOUT_DETAILS,
      page: () => HIITDetailsScreen(),
      binding: HIITDetailsBindings(),
    )
  ];
}
