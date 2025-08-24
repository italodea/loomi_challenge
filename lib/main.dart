import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loomi_chalenge/routes/app_routes.dart';
import 'package:loomi_chalenge/services/firebase_auth_service.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  await GetStorage.init(); // Initialize GetStorage
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final GetStorage storage = GetStorage();
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: const Key('MainApp'),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: storage.read('accessToken')?.isNotEmpty == true
          ? AppRoutes.home
          : AppRoutes.login,
      getPages: AppRoutes.routes,
      enableLog: true,
    );
  }
}
