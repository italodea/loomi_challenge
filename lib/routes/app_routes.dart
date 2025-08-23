import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:loomi_chalenge/pages/forgot_password_page.dart';
import 'package:loomi_chalenge/pages/login_page.dart';
import 'package:loomi_chalenge/pages/signup_page.dart';

class AppRoutes {

  static const String login = '/login';
  static const String home = '/home';
  static const String forgotPassword = '/forgot-password';
  static const String signup = '/signup';

  static final routes = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordPage()),
    GetPage(name: signup, page: () => SignupPage()),
  ];
}