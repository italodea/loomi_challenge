import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/repositories/models/const/player_fill.dart';
import 'package:loomi_chalenge/repositories/models/const/player_visible.dart';
import 'package:loomi_chalenge/repositories/models/data/movie.dart';
import 'package:video_player/video_player.dart';

class WatchMovieController extends GetxController {
  WatchMovieController(this.movie);

  final Rxn<VideoPlayerController> videoPlayerController =
      Rxn<VideoPlayerController>();
  final Movie? movie;

  final Rxn<Duration> currentPosition = Rxn<Duration>();
  final Rxn<Duration> totalDuration = Rxn<Duration>();

  final Rxn<PlayerVisible> playerVisible = Rxn<PlayerVisible>();
  final Rxn<PlayerVisible> configVisible = Rxn<PlayerVisible>(
    PlayerVisible.hidden,
  );
  final Rxn<PlayerVisible> commentsVisible = Rxn<PlayerVisible>(
    PlayerVisible.hidden,
  );

  final Rxn<int> videoWidth = Rxn<int>(0);
  final Rxn<int> videoHeight = Rxn<int>(0);
  final Rxn<PlayerFill> playerFill = Rxn<PlayerFill>(PlayerFill.contain);

  Timer? _idleTimer;

  @override
  void onInit() {
    super.onInit();
    setHorizontal();
    _initializeVideoPlayer();
    idleInterface();
  }

  void _initializeVideoPlayer() {
    if (movie != null) {
      videoPlayerController.value = VideoPlayerController.networkUrl(
        Uri.parse(movie!.streamLink),
      );
      videoPlayerController.value!.initialize().then((_) {
        videoPlayerController.value!.play();
        totalDuration.value = videoPlayerController.value!.value.duration;
        videoWidth.value = videoPlayerController.value!.value.size.width
            .toInt();
        videoHeight.value = videoPlayerController.value!.value.size.height
            .toInt();
        update();
      });

      videoPlayerController.value!.addListener(() {
        currentPosition.value = videoPlayerController.value!.value.position;
      });
    }
  }

  void setHorizontal() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void setVertical() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void togglePlayPause() {
    if (videoPlayerController.value?.value.isPlaying ?? false) {
      videoPlayerController.value?.pause();
    } else {
      videoPlayerController.value?.play();
    }
  }

  void toggleInterface() {
    if (playerVisible.value == PlayerVisible.hidden) {
      playerVisible.value = PlayerVisible.visible;
      idleInterface();
    } else {
      playerVisible.value = PlayerVisible.hidden;
    }
  }

  void seekTo(Duration position) {
    videoPlayerController.value?.seekTo(position);
  }

  double getWidth(BuildContext context) {
    if (videoHeight.value! > 10 && videoWidth.value! > 10) {
      if (playerFill.value == PlayerFill.cover) {
        return MediaQuery.of(context).size.width;
      } else if (playerFill.value == PlayerFill.fill) {
        return MediaQuery.of(context).size.width;
      }

      if (videoWidth.value! > videoHeight.value!) {
        double proportion =
            MediaQuery.of(context).size.height / videoHeight.value!.toDouble();
        return videoWidth.value!.toDouble() * (proportion + 0);
      } else {
        return MediaQuery.of(context).size.width;
      }
    }
    return 10;
  }

  double getHeight(BuildContext context) {
    if (videoHeight.value! > 10 && videoWidth.value! > 10) {
      if (playerFill.value == PlayerFill.cover) {
        return videoHeight.value!.toDouble();
      } else if (playerFill.value == PlayerFill.fill) {
        return MediaQuery.of(context).size.height;
      }
      if (videoWidth.value! > videoHeight.value!) {
        double proportion =
            MediaQuery.of(context).size.width / videoWidth.value!.toDouble();
        return videoHeight.value!.toDouble() * (proportion - 0.12);
      } else {
        return videoWidth.value!.toDouble();
      }
    }
    return 10;
  }

  String getCurrentPosition() {
    final position =
        videoPlayerController.value?.value.position ?? Duration.zero;
    currentPosition.value = position;
    return formatDuration(position);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void idleInterface() {
    // Store the timer so it can be cancelled later
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(seconds: 3), () {
      playerVisible.value = PlayerVisible.hidden;
    });
  }

  @override
  void onClose() {
    setVertical();
    videoPlayerController.value?.pause();
    videoPlayerController.value?.dispose();
    super.onClose();
  }

  void forward() {
    videoPlayerController.value?.seekTo(
      (currentPosition.value ?? Duration.zero) + const Duration(seconds: 15),
    );
  }

  void rewind() {
    videoPlayerController.value?.seekTo(
      (currentPosition.value ?? Duration.zero) - const Duration(seconds: 15),
    );
  }

  void toggleFullScreen() {
    if (playerFill.value == PlayerFill.contain) {
      playerFill.value = PlayerFill.cover;
    } else if (playerFill.value == PlayerFill.cover) {
      playerFill.value = PlayerFill.fill;
    } else {
      playerFill.value = PlayerFill.contain;
    }
    print("Player fill mode changed to: ${playerFill.value}");
  }

  void toggleConfig() {
    if (configVisible.value == PlayerVisible.hidden) {
      configVisible.value = PlayerVisible.visible;
    } else {
      configVisible.value = PlayerVisible.hidden;
    }
  }

  void toggleComments() {
    if (commentsVisible.value == PlayerVisible.hidden) {
      commentsVisible.value = PlayerVisible.visible;
      _idleTimer?.cancel();
    } else {
      commentsVisible.value = PlayerVisible.hidden;
      idleInterface();
    }
  }
}
