import 'package:get/route_manager.dart';
import 'package:loomi_chalenge/pages/confirm_signup_page.dart';
import 'package:loomi_chalenge/pages/forgot_password_page.dart';
import 'package:loomi_chalenge/pages/login_page.dart';
import 'package:loomi_chalenge/pages/signup_page.dart';

class AppRoutes {
  // Route names as constants
  static const login = '/login';
  static const home = '/home';
  static const forgotPassword = '/forgot-password';
  static const signup = '/signup';
  static const confirmSignup = '/confirm-signup';

  // Centralized list of all routes
  static final List<GetPage> routes = [
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      name: signup,
      page: () => const SignupPage(),
    ),
    GetPage(
      name: confirmSignup,
      page: () {
        final args = Get.arguments;
        final userId = args is Map && args['userId'] is String ? args['userId'] as String : '';
        return ConfirmSignupPage(userId: userId);
      },
    ),
  ];

  // Prevent instantiation
  AppRoutes._();
}