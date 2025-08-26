import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:loomi_chalenge/components/player_comments.dart';
import 'package:loomi_chalenge/components/player_config.dart';
import 'package:loomi_chalenge/components/player_interface.dart';
import 'package:loomi_chalenge/controllers/watch_movie_controller.dart';
import 'package:loomi_chalenge/repositories/models/const/player_visible.dart';
import 'package:video_player/video_player.dart';

class WatchMoviePage extends StatefulWidget {
  const WatchMoviePage({super.key});

  @override
  State<WatchMoviePage> createState() => _WatchMoviePageState();
}

class _WatchMoviePageState extends State<WatchMoviePage> {
  final WatchMovieController controller = Get.put(
    WatchMovieController(Get.arguments),
  );
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final videoController = controller.videoPlayerController.value;
      if (videoController != null) {
        return Stack(
          children: [
            OverflowBox(
              maxWidth: controller.getWidth(context),
              maxHeight: controller.getHeight(context),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.getWidth(context),
                    height: controller.getHeight(context),
                    child: VideoPlayer(videoController),
                  ),
                ),
              ),
            ),
            PlayerInterface(),
            controller.configVisible.value == PlayerVisible.visible ?
            PlayerConfig() : Container(),
            controller.commentsVisible.value == PlayerVisible.visible ?
            Align(
                alignment: Alignment.centerRight,
                child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                  );
                },
                child: controller.commentsVisible.value == PlayerVisible.visible
                  ? PlayerComments(key: ValueKey('visible'))
                  : SizedBox(key: ValueKey('hidden')),
                ),
            ) : Container(),
          ],
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
