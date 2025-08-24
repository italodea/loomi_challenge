import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loomi_chalenge/components/cutom_button.dart';

import '../../routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    String token = storage.read('accessToken') ?? '';
    return Scaffold(
      body: Center(
        child: CustomButton(label: "Sair", onPressed: () async{
          await storage.erase();
          Get.offAllNamed(AppRoutes.login);
        }),
      ),
    );
  }
}