import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/errors/custom_exception.dart';
import 'package:loomi_chalenge/services/firebase_auth_service.dart';

class ForgotPasswordController extends GetxController {

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  final TextEditingController emailController = TextEditingController();

  Future<void> sendPasswordResetEmail() async {
    try {
      await _firebaseAuthService.sendPasswordResetEmail(emailController.text);
      } catch (e) {
        throw CustomException(e);
    }
  }
}