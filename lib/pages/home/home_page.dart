import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loomi_chalenge/components/custom_circle_avatar.dart';
import 'package:loomi_chalenge/components/home_background.dart';
import 'package:loomi_chalenge/components/movie_poster_component.dart';
import 'package:loomi_chalenge/controllers/home_controller.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetStorage storage = GetStorage();
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomeBackground(),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, top: 70),
            child: Obx(() {
              if (_controller.movies.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30),
                      Center(
                        child: Image.asset(
                          'assets/img/logo_minimal.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Center(
                        child: CustomCircleAvatar(),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        "Now showing",
                        style: AppTheme.textThemeSecondary.labelLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  MoviePosterComponent(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
