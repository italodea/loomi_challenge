import 'dart:developer';
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
import 'package:loomi_chalenge/utils/file_util.dart';

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

  final List<File> userImage = <File>[].obs;

  Future<void> signInWithGoogle() async {
    try {
      UserCredential? user = await _authService.googleSignIn();
      if (user != null) {
        String token = await _authService.getAuthToken() ?? "";
        if (token.isNotEmpty) {
          await _storage.write('accessToken', token);
          userNameController.text = user.user?.displayName ?? '';
          userImage.clear();
          if (user.user?.photoURL != null) {
            if (user.user!.photoURL!.isNotEmpty) {
              File file = await FileUtil.downloadFile(user.user!.photoURL!);
              userImage.add(file);
            }
          }
          Get.offAllNamed(AppRoutes.confirmSignup);
        }
      }
    } catch (e) {
      GetStorage().erase();
      throw CustomException(e);
    }
  }

  Future<void> registerWithEmailAndPassword() async {
    try {
      UserCredential user = await _authService.registerUserWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );

      String token = await _authService.getAuthToken() ?? "";

      userNameController.text = emailController.text.split('@').first;

      await customAPI.register(
        token,
        userNameController.text,
        emailController.text,
        user.user?.uid ?? "",
      );

      if (token.isNotEmpty) {
        _storage.write('accessToken', token);
      }
    } catch (e) {
      throw CustomException(e);
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      userImage.clear();
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
      userImage.clear();
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

  Future<void> getCurrentUser() async {
    final token = await _authService.getAuthToken();
    if (token != null) {
      final tokenParts = token.split('.');
      for (var part in tokenParts) {
        log(part);
      }
    }
  }

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      await registerWithEmailAndPassword();
      Get.toNamed(AppRoutes.confirmSignup);
    }
  }

  Future<void> completeSignUp() async {
    try {
      await getCurrentUser();
      if (completeSignUpFormKey.currentState!.validate()) {
        if (userImage.isNotEmpty) {
          String url = await customAPI.uploadProfilePicture(
            _storage.read('accessToken'),
            userImage.first,
          );
          await _authService.updatePhotoURL(url);
        }
        await _authService.updateDisplayName(userNameController.text);

        await customAPI.updateMe(
          _storage.read('accessToken'),
          username: userNameController.text,
          email: emailController.text,
          finishedOnboarding: true,
        );
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      throw CustomException(e);
    }
  }
}
