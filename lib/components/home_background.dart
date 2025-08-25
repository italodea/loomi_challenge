import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/controllers/home_controller.dart';
import 'package:loomi_chalenge/repositories/models/const/player_status.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class HomeBackground extends StatefulWidget {
  const HomeBackground({super.key});

  @override
  State<HomeBackground> createState() => _HomeBackgroundState();
}

class _HomeBackgroundState extends State<HomeBackground> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final videoController = controller.videoPlayerController.value;
    if (videoController == null) {
      return _loadingEffect();
    }
    return Stack(
      children: [
        Obx(() {
          final value = controller.playerStatus.value;
          if (value == PlayerStatus.playing) {
            return SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: videoController.value.size.width,
                  height: videoController.value.size.height,
                  child: VideoPlayer(videoController),
                ),
              ),
            );
          } else {
            return Image.network(
              controller.getCurrentMovie()!.poster.url,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            );
          }
        }),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black87, Colors.transparent],
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: SizedBox.expand(child: Container()),
          ),
        ),
      ],
    );
  }

  Widget _loadingEffect() {
    return Shimmer(
      gradient: LinearGradient(
        colors: [AppTheme.primaryDarkColor, AppTheme.backgroundColor],
      ),
      child: SizedBox.expand(
        child: Container(height: 200, width: 200, color: Colors.red),
      ),
    );
  }
}
