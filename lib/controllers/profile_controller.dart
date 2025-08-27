import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loomi_chalenge/services/firebase_auth_service.dart';

class ProfileController extends GetxController {
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  final user = Rx<User?>(null); 
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    user.value = await firebaseAuthService.getCurrentUser();
  }

  Future<void> logout() async {
    await firebaseAuthService.signOut();
    await storage.erase();
    Get.offAllNamed('/login');
  }

  Future<void> deleteAccount() async {
    await firebaseAuthService.deleteAccount();
    await storage.erase();
    Get.offAllNamed('/login');
  }
}