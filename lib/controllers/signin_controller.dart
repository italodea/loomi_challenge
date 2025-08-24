import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loomi_chalenge/routes/app_routes.dart';
import 'package:loomi_chalenge/services/firebase_auth_service.dart';

class SigninController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuthService _authService = FirebaseAuthService();
  final GetStorage _storage = GetStorage();

  Future<void> signIn() async {
    if (formKey.currentState?.validate() ?? false) {
      UserCredential? user = await _authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );

      if (user != null) {
        String token = await _authService.getAuthToken() ?? "";
        if(token.isNotEmpty) {
          await _storage.write('accessToken', token);
          Get.offAllNamed(AppRoutes.home);
        }
      } else {
        Get.snackbar('Login Failed', 'Invalid email or password');
      }
    }
  }
}
