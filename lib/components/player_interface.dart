import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/custom_icon_button.dart';
import 'package:loomi_chalenge/components/player_button.dart';
import 'package:loomi_chalenge/controllers/watch_movie_controller.dart';
import 'package:loomi_chalenge/repositories/models/const/player_visible.dart';
import 'package:loomi_chalenge/themes/app_icons.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class PlayerInterface extends StatelessWidget {
  PlayerInterface({super.key});

  final WatchMovieController controller = Get.find<WatchMovieController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          controller.toggleInterface();
        },
        child: Obx(() {
          if (controller.playerVisible.value == PlayerVisible.hidden) {
            return Container();
          }
          return Container(
            width: controller.commentsVisible.value == PlayerVisible.hidden ? double.infinity : MediaQuery.of(context).size.width - 400,
            height: double.infinity,
            color: Colors.black54,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppTheme.primaryColor,
                          size: 40,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          PlayerButton(
                            icon: AppIcons.subtitles,
                            label: "subtitles or audio",
                            onPressed: () async {
                              controller.toggleConfig();
                            },
                          ),
                          SizedBox(width: 12),
                          PlayerButton(
                            icon: AppIcons.comment,
                            label: "Comments 324",
                            onPressed: () async {
                              controller.toggleComments();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PlayerButton(
                        onPressed: () async {
                          controller.rewind();
                        },
                        icon: AppIcons.backward,
                        size: 40,
                      ),
                      SizedBox(width: 40),
                      PlayerButton(
                        onPressed: () async {
                          controller.togglePlayPause();
                        },
                        icon: AppIcons.pause,
                        size: 60,
                      ),
                      SizedBox(width: 40),
                      PlayerButton(
                        onPressed: () async {
                          controller.forward();
                        },
                        icon: AppIcons.forward,
                        size: 40,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Slider(
                        value:
                            (controller.currentPosition.value?.inSeconds ?? 0)
                                .toDouble(),
                        min: 0,
                        max: (controller.totalDuration.value?.inSeconds ?? 1)
                            .toDouble(),
                        onChanged: (value) {
                          controller.seekTo(Duration(seconds: value.toInt()));
                        },
                        activeColor: AppTheme.primaryColor,
                        inactiveColor: Colors.white30,
                      ),
                    ),
                    Text(
                      controller.formatDuration(
                        controller.totalDuration.value ?? Duration.zero,
                      ),
                      style: AppTheme.textThemeSecondary.labelLarge,
                    ),
                    CustomIconButton(
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        controller.toggleFullScreen();
                      },
                      icon: AppIcons.icon(
                        AppIcons.fullscreen,
                        size: 30,
                        color: Colors.white,
                      ),
                      minimumSize: Size(30, 30),
                      maximumSize: Size(100, 70),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
