import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loomi_chalenge/repositories/dio/api.dart';
import 'package:loomi_chalenge/repositories/models/const/player_status.dart';
import 'package:loomi_chalenge/repositories/models/data/movie.dart';
import 'package:loomi_chalenge/services/firebase_auth_service.dart';
import 'package:loomi_chalenge/services/local_auth.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  final GetStorage storage = GetStorage();
  final FirebaseAuthService authService = FirebaseAuthService();
  final CustomAPI api = CustomAPI();
  final LocalAuth localAuth = LocalAuth();

  final RxList<Movie> movies = <Movie>[].obs;
  final Rx<PlayerStatus> playerStatus = PlayerStatus.paused.obs;
  final Rxn<VideoPlayerController> videoPlayerController = Rxn<VideoPlayerController>();
  final RxInt currentIndex = 0.obs;
  final Rxn<User> user = Rxn<User>();

  @override
  void onInit() {
    _checkAuth();

    super.onInit();
    getMovies();
    // set orientation to landscape
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void _checkAuth() async {
    final isAuth = await localAuth.checkAuth();
    if (!isAuth) {
      Get.offAllNamed('/login');
    }
    await authService.getCurrentUser().then((user) {
      if (user != null) {
        this.user.value = user;
      }
    });
  }

  Future<void> getMovies() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final token = await authService.getAuthToken();
      if (token != null) {
        final fetchedMovies = await api.getMovies(token);
        movies.assignAll(fetchedMovies);
        if (movies.isNotEmpty) {
          await _initializeVideoPlayer(movies[currentIndex.value].streamLink);
        }
      }
    } catch (e) {
      // Handle error, e.g. show snackbar
      print('Error fetching movies: $e');
    }
  }

  Movie? getCurrentMovie() => movies.isNotEmpty ? movies[currentIndex.value] : null;

  Future<void> nextIndex() async {
    playerStatus.value = PlayerStatus.paused;
    await _disposeVideoPlayer();

    if (currentIndex.value < movies.length - 1) {
      currentIndex.value++;
    } else {
      currentIndex.value = 0;
    }

    await _initializeVideoPlayer(movies[currentIndex.value].streamLink);
    update();
  }

  Future<void> _initializeVideoPlayer(String url) async {
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(url),
      viewType: VideoViewType.platformView,
    );
    videoPlayerController.value = controller;
    await controller.initialize().then((_) {
      if(videoPlayerController != null) {
        Future.delayed(const Duration(seconds: 2), () {
          controller.play();
          playerStatus.value = PlayerStatus.playing;
          update();
        });
      }
    });
    controller.setLooping(false);
    controller.setVolume(0);
    controller.setPlaybackSpeed(5); // Use normal speed
    controller.addListener(() {
      if (controller.value.position >= controller.value.duration &&
          controller.value.isInitialized &&
          !controller.value.isPlaying) {
        nextIndex();
      }
    });
    playerStatus.value = PlayerStatus.paused;
  }

  Future<void> _disposeVideoPlayer() async {
    final controller = videoPlayerController.value;
    if (controller != null) {
      await controller.dispose();
      videoPlayerController.value = null;
    }
  }

  Future<void> logout() async {
    await authService.signOut();
    await storage.erase();
    Get.offAllNamed('/login');
  }

  Future<void> getCurrentUser() async {
    final token = await authService.getAuthToken();
    if (token != null) {
      final tokenParts = token.split('.');
      for (var part in tokenParts) {
        print(part);
      }
    }
  }

  @override
  void onClose() {
    _disposeVideoPlayer();
    super.onClose();
  }
}