import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loomi_chalenge/errors/custom_exception.dart';
import 'package:loomi_chalenge/repositories/dio/api.dart';
import 'package:loomi_chalenge/routes/app_routes.dart';
import 'package:loomi_chalenge/services/firebase_auth_service.dart';
import 'package:get_storage/get_storage.dart';

class SignupController extends GetxController {
  final GetStorage _storage = GetStorage();
  final FirebaseAuthService _authService = FirebaseAuthService();
  final CustomAPI customAPI = CustomAPI();
  final ImagePicker _imagePicker = ImagePicker();

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

  Future<void> signInWithGoogle() async {
    UserCredential? user = await _authService.googleSignIn();
    if (user != null) {
      String token = await _authService.getAuthToken() ?? "";
      if (token.isNotEmpty) {
        await _storage.write('accessToken', token);
        Get.offAllNamed(AppRoutes.home);
      }
    }
  }

  Future<void> registerWithEmailAndPassword() async {
    try {
      UserCredential user = await _authService.registerUserWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );

      await _authService.updateDisplayName(userNameController.text);

      await customAPI.register(
        userNameController.text,
        emailController.text,
        passwordController.text,
        user.user?.uid ?? "",
      );

      String token = user.credential?.accessToken ?? "";

      token = await _authService.getAuthToken() ?? "";
      if (token.isNotEmpty) {
        _storage.write('accessToken', token);
      }
    } catch (e) {
      throw CustomException(e);
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        userImage.add(File(pickedFile.path));
      }
      Get.back();
    } catch (e) {
      throw CustomException(e);
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        userImage.add(File(pickedFile.path));
      }
      Get.back();
    } catch (e) {
      throw CustomException(e);
    }
  }
}
