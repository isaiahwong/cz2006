import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/screens/workout/camera/pose.dart';
import 'package:get/get.dart';

class RoutePaths {
  static const ROOT = '/';
  static const LOGIN = '/auth/login';

  static const REGISTER = '/auth/register';
  static const APP = '/app';
  static const HIIT_ACTIVE = '/workout/hiit/active';
  static const HIIT_DETAILS = '/workout/hiit/details';
}

class Routes {
  static final routes = [
    GetPage(
      name: RoutePaths.ROOT,
      page: () => SplashScreen(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 200),
    ),
    GetPage(
        name: RoutePaths.LOGIN,
        page: () => LoginScreen(),
        binding: LoginBindings()),
    GetPage(
      name: RoutePaths.REGISTER,
      page: () => RegisterScreen(),
      binding: RegisterUserBindings(),
    ),
    GetPage(
        name: RoutePaths.APP,
        page: () => AppScreen(),
        binding: AppScreenBindings(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 700)),
    GetPage(
      name: RoutePaths.HIIT_ACTIVE,
      page: () => ActiveHIITScreen(),
      binding: ActiveHIITBindings(),
    ),
    GetPage(
      name: RoutePaths.HIIT_DETAILS,
      page: () => HIITDetailsScreen(),
      binding: HIITDetailsBindings(),
    )
  ];
}
