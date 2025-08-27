import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/repositories/models/const/player_fill.dart';
import 'package:loomi_chalenge/repositories/models/const/player_status.dart';
import 'package:loomi_chalenge/repositories/models/const/player_visible.dart';
import 'package:loomi_chalenge/repositories/models/data/comment.dart';
import 'package:loomi_chalenge/repositories/models/data/movie.dart';
import 'package:loomi_chalenge/services/comments_service.dart';
import 'package:loomi_chalenge/services/firebase_auth_service.dart';
import 'package:video_player/video_player.dart';

class WatchMovieController extends GetxController {
  WatchMovieController(this.movie);

  final Movie? movie;

  final videoPlayerController = Rxn<VideoPlayerController>();
  final currentPosition = Rx<Duration>(Duration.zero);
  final totalDuration = Rx<Duration>(Duration.zero);

  final playerVisible = Rx<PlayerVisible>(PlayerVisible.hidden);
  final configVisible = Rx<PlayerVisible>(PlayerVisible.hidden);
  final commentsVisible = Rx<PlayerVisible>(PlayerVisible.hidden);
  final isPlaying = Rx<PlayerStatus>(PlayerStatus.playing);

  final videoWidth = Rx<int>(0);
  final videoHeight = Rx<int>(0);
  final playerFill = Rx<PlayerFill>(PlayerFill.contain);
  final comments = Rx<List<Comment>?>(null);

  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final CommentsService commentsService = CommentsService();
  Timer? _idleTimer;

  @override
  void onInit() {
    super.onInit();
    setHorizontal();
    _initializeVideoPlayer();
    _idleInterface();
  }

  Future<void> _initializeVideoPlayer() async {
    if (movie == null) return;

    final controller = VideoPlayerController.networkUrl(Uri.parse(movie!.streamLink));
    videoPlayerController.value = controller;

    await controller.initialize();
    controller.play();
    totalDuration.value = controller.value.duration;
    videoWidth.value = controller.value.size.width.toInt();
    videoHeight.value = controller.value.size.height.toInt();

    controller.addListener(() {
      currentPosition.value = controller.value.position;
    });

    update();
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
    final controller = videoPlayerController.value;
    if (controller == null) return;
    controller.value.isPlaying ? controller.pause() : controller.play();
    isPlaying.value = controller.value.isPlaying ? PlayerStatus.playing : PlayerStatus.paused;
  }

  void toggleInterface() {
    playerVisible.value = playerVisible.value == PlayerVisible.hidden
        ? PlayerVisible.visible
        : PlayerVisible.hidden;
    if (playerVisible.value == PlayerVisible.visible) {
      _idleInterface();
    }
  }

  void seekTo(Duration position) {
    videoPlayerController.value?.seekTo(position);
  }

  double getWidth(BuildContext context) {
    final width = videoWidth.value;
    final height = videoHeight.value;
    if (height > 10 && width > 10) {
      switch (playerFill.value) {
        case PlayerFill.cover:
        case PlayerFill.fill:
          return MediaQuery.of(context).size.width;
        default:
          if (width > height) {
            final proportion = MediaQuery.of(context).size.height / height;
            return width * proportion;
          }
          return MediaQuery.of(context).size.width;
      }
    }
    return 10;
  }

  double getHeight(BuildContext context) {
    final width = videoWidth.value;
    final height = videoHeight.value;
    if (height > 10 && width > 10) {
      switch (playerFill.value) {
        case PlayerFill.cover:
          return height.toDouble();
        case PlayerFill.fill:
          return MediaQuery.of(context).size.height;
        default:
          if (width > height) {
            final proportion = MediaQuery.of(context).size.width / width;
            return height * (proportion - 0.12);
          }
          return width.toDouble();
      }
    }
    return 10;
  }

  String getCurrentPosition() {
    final position = videoPlayerController.value?.value.position ?? Duration.zero;
    currentPosition.value = position;
    return formatDuration(position);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _idleInterface() {
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
    _idleTimer?.cancel();
    super.onClose();
  }

  void forward() {
    seekTo((currentPosition.value) + const Duration(seconds: 15));
  }

  void rewind() {
    seekTo((currentPosition.value) - const Duration(seconds: 15));
  }

  void toggleFullScreen() {
    switch (playerFill.value) {
      case PlayerFill.contain:
        playerFill.value = PlayerFill.cover;
        break;
      case PlayerFill.cover:
        playerFill.value = PlayerFill.fill;
        break;
      case PlayerFill.fill:
        playerFill.value = PlayerFill.contain;
        break;
      default:
        throw UnimplementedError();
    }
  }

  void toggleConfig() {
    configVisible.value = configVisible.value == PlayerVisible.hidden
        ? PlayerVisible.visible
        : PlayerVisible.hidden;
  }

  void toggleComments() {
    setHorizontal();
    commentsVisible.value = commentsVisible.value == PlayerVisible.hidden
        ? PlayerVisible.visible
        : PlayerVisible.hidden;
    if (commentsVisible.value == PlayerVisible.visible) {
      _idleTimer?.cancel();
      if (comments.value?.isEmpty ?? true) {
        loadComments();
      }
    } else {
      _idleInterface();
    }
  }

  Future<void> loadComments() async {
    final token = await firebaseAuthService.getAuthToken() ?? '';
    comments.value = await commentsService.getCommentsByMovieId(movie!.id);
  }
}
