import 'package:get/route_manager.dart';
import 'package:loomi_chalenge/pages/forgot-password/email_sent_page.dart';
import 'package:loomi_chalenge/pages/home/home_page.dart';
import 'package:loomi_chalenge/pages/signup/confirm_signup_page.dart';
import 'package:loomi_chalenge/pages/forgot-password/forgot_password_page.dart';
import 'package:loomi_chalenge/pages/login/login_page.dart';
import 'package:loomi_chalenge/pages/signup/signup_page.dart';
import 'package:loomi_chalenge/pages/watch-movie/watch_movie_page.dart';

class AppRoutes {
  // Route names as constants
  static const login = '/login';
  static const home = '/home';
  static const forgotPassword = '/forgot-password';
  static const emailSent = '/email-sent';
  static const signup = '/signup';
  static const confirmSignup = '/confirm-signup';
  static const watchMovie = '/watch-movie';

  // Centralized list of all routes
  static final List<GetPage> routes = [
    GetPage(
      name: login,
      page: () => const LoginPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signup,
      page: () => const SignupPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: confirmSignup,
      transition: Transition.fadeIn,
      page: () => ConfirmSignupPage(), // Replace with actual user ID
    ),
    GetPage(
      name: emailSent,
      page: () => const EmailSent(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: watchMovie,
      page: () => const WatchMoviePage(),
      transition: Transition.fadeIn,
    ),
  ];

  // Prevent instantiation
  AppRoutes._();


  
}