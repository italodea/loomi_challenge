import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loomi_chalenge/repositories/dio/api.dart';
import 'package:loomi_chalenge/repositories/models/const/player_status.dart';
import 'package:loomi_chalenge/repositories/models/data/movie.dart';
import 'package:loomi_chalenge/services/firebase_auth_service.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  final GetStorage storage = GetStorage();
  final FirebaseAuthService authService = FirebaseAuthService();
  final CustomAPI api = CustomAPI();

  final RxList<Movie> movies = <Movie>[].obs;
  final Rx<PlayerStatus> playerStatus = PlayerStatus.paused.obs;
  final Rxn<VideoPlayerController> videoPlayerController =
      Rxn<VideoPlayerController>();
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getMovies();
  }

  Future<void> getMovies() async {
    try {
      final token = await authService.getAuthToken();
      if (token != null) {
        final fetchedMovies = await api.getMovies(token);
        movies.assignAll(fetchedMovies);
        if (movies.isNotEmpty) {
          await updateVideoController();
        }
      }
    } catch (e) {
      // Handle error (e.g., show snackbar)
    }
  }

  Movie? getCurrentMovie() =>
      movies.isNotEmpty ? movies[currentIndex.value] : null;

  Future<void> nextIndex() async {
    if (movies.isEmpty) return;
    currentIndex.value = (currentIndex.value + 1) % movies.length;
    await disposeVideoController();
    await updateVideoController();
    update();
  }

  Future<void> disposeVideoController() async {
    final controller = videoPlayerController.value;
    if (controller != null) {
      await controller.dispose();
      videoPlayerController.value = null;
    }
  }

  void playVideo() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      final controller = videoPlayerController.value;
      if (controller != null) {
        controller.play();
        playerStatus.value = PlayerStatus.playing;
      }
    });
  }

  Future<void> updateVideoController() async {
    playerStatus.value = PlayerStatus.paused;
    final movie = getCurrentMovie();
    if (movie == null) return;
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(movie.streamLink),
      viewType: VideoViewType.platformView,
    );
    videoPlayerController.value = controller;
    await controller.initialize();
    controller.setLooping(false);
    controller.setVolume(0);
    controller.addListener(() {
      final value = controller.value;
      if (value.position >= value.duration &&
          value.isInitialized &&
          !value.isPlaying) {
        nextIndex();
      }
    });
    playVideo();
  }

  Future<void> logout() async {
    await authService.signOut();
    await storage.erase();
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    disposeVideoController();
    super.onClose();
  }
}
