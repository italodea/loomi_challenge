import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/services/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class SignupController extends GetxController {

  final GetStorage storage = GetStorage();
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final completeSignUpFormKey = GlobalKey<FormState>();

  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final shinePasswordInputBorder = true.obs;
  final shineConfirmPasswordInputBorder = true.obs;
  final List<File> userImage = <File>[].obs;


  void loginWithGoogle() async {
    try {
      UserCredential? credentials = await firebaseAuthService.googleSignIn();
      if (credentials != null && credentials.user != null && credentials.credential != null) {
        storage.write('userEmail', credentials.user?.email);
        storage.write('userName', credentials.user?.displayName);
        storage.write('accessToken', credentials.credential?.accessToken);
        Get.offAllNamed('/home');
      }
    } catch (e) {
      // Tratar erro
    }
  }

}