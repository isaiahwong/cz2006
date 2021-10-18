import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/screens/workout/cycling/active/active_cycling_bindings.dart';
import 'package:fitness/app/screens/workout/cycling/active/active_cycling_screen.dart';
import 'package:fitness/app/screens/workout/hiit/active/pose/pose.dart';
import 'package:fitness/app/screens/workout/hiit/room/waiting_room_screen.dart';
import 'package:get/get.dart';

class RoutePaths {
  static const ROOT = '/';
  static const LOGIN = '/auth/login';

  static const REGISTER = '/auth/register';
  static const APP = '/app';
  static const HIIT_ACTIVE = '/workout/hiit/active';
  static const HIIT_DETAILS = '/workout/hiit/details';
  static const HIIT_WAITING_ROOM = '/workout/hiit/room/waiting';
  static const CYCLING_DETAILS = '/workout/cycling/details';
  static const CYCLING_ACTIVE = '/workout/cycling/active';
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
      name: RoutePaths.HIIT_DETAILS,
      page: () => HIITDetailsScreen(),
      binding: HIITDetailsBindings(),
    ),
    GetPage(
      name: RoutePaths.HIIT_ACTIVE,
      page: () => ActiveHIITScreen(),
      binding: ActiveHIITBindings(),
    ),
    GetPage(
      name: RoutePaths.HIIT_WAITING_ROOM,
      page: () => WaitingRoomScreen(),
      binding: WaitingRoomBindings(),
    ),
    GetPage(
      name: RoutePaths.CYCLING_DETAILS,
      page: () => CyclingDetailsScreen(),
      binding: HIITDetailsBindings(),
    ),
    GetPage(
      name: RoutePaths.CYCLING_ACTIVE,
      page: () => ActiveCyclingScreen(),
      binding: ActiveCyclingBindings(),
    ),
  ];
}
