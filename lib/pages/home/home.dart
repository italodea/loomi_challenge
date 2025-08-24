import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

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
        child: Text("Token $token"),
      ),
    );
  }
}