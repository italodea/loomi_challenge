import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:loomi_chalenge/routes/app_routes.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
      enableLog: true,
    );
  }
}
