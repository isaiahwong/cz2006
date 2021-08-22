import 'package:frontend/app/screens/auth/register_screen.dart';
import 'package:frontend/app/screens/screens.dart';
import 'package:get/get.dart';

class RoutePaths {
  static const ROOT = '/';
  static const LOGIN = '/auth/login';
  static const REGISTER = '/auth/register';
}

class Routes {
  static final routes = [
    GetPage(name: RoutePaths.ROOT, page: () => SplashScreen()),
    GetPage(name: RoutePaths.LOGIN, page: () => LoginScreen()),
    GetPage(name: RoutePaths.REGISTER, page: () => RegisterScreen()),
  ];
}
