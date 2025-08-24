import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/repositories/dio/api.dart';
import 'package:loomi_chalenge/services/firebase_auth_service.dart';
import 'package:get_storage/get_storage.dart';

class SignupController extends GetxController {
  final GetStorage storage = GetStorage();
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final CustomAPI customAPI = CustomAPI();

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
      if (credentials != null &&
          credentials.user != null &&
          credentials.credential != null) {
        // storage.write('userEmail', credentials.user?.email);
        // storage.write('userName', credentials.user?.displayName);
        // storage.write('accessToken', credentials.credential?.accessToken);
        // Get.offAllNamed('/home');
      }
    } catch (e) {
      print("-------------ERROR-------------");
      print(e);
      print("-------------ERROR-------------");
    }
  }

  Future<void> registerWithEmailAndPassword() async {
    try {
      UserCredential user = await firebaseAuthService
          .registerUserWithEmailAndPassword(
            emailController.text,
            passwordController.text,
          );

      await firebaseAuthService.updateDisplayName(
        userNameController.text,
      );

      await customAPI.register(
        userNameController.text,
        emailController.text,
        passwordController.text,
        user.user?.uid ?? "",
      );

      String token = user.credential?.accessToken ?? "";

      token = await firebaseAuthService.getAuthToken() ?? "";
      if(token.isNotEmpty){
        storage.write('accessToken', token);
      }
      print("Token: $token");
    } catch (e) {
      print("-------------ERROR-------------");
      print(e);
      print("-------------ERROR-------------");
    }
  }

  getData(){
    print("User Name: ${userNameController.text}");
    print("Email: ${emailController.text}");
    print("Password: ${passwordController.text}");
    print("Confirm Password: ${confirmPasswordController.text}");
  }
}
