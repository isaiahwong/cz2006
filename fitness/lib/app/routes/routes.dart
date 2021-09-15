import 'package:fitness/app/screens/auth/login/login_bindings.dart';
import 'package:fitness/app/screens/auth/register_bindings.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:get/get.dart';

class RoutePaths {
  static const ROOT = '/';
  static const LOGIN = '/auth/login';

  static const REGISTER = '/auth/register';
  static const DASHBOARD = '/dashboard';
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
      name: RoutePaths.DASHBOARD,
      page: () => BaseScreen(),
    )
  ];
}
