import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/movie_poster_footer.dart';
import 'package:loomi_chalenge/components/movie_poster_header.dart';
import 'package:loomi_chalenge/controllers/home_controller.dart';
import 'package:loomi_chalenge/repositories/models/const/player_status.dart';
import 'package:loomi_chalenge/repositories/models/data/movie.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class MoviePosterComponent extends StatefulWidget {
  const MoviePosterComponent({super.key});

  @override
  State<MoviePosterComponent> createState() => _MoviePosterComponentState();
}

class _MoviePosterComponentState extends State<MoviePosterComponent> {
  final HomeController controller = Get.find<HomeController>();

  Movie? movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200 < 400
          ? MediaQuery.of(context).size.height - 170
          : MediaQuery.of(context).size.height - 200,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Obx(() {
            final videoController = controller.videoPlayerController.value;
            if (videoController == null) {
              return _loadingEffect(context);
            }
            final value = controller.playerStatus.value;
            if (value == PlayerStatus.playing) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    clipBehavior: Clip.none,
                    child: SizedBox(
                      width: videoController.value.size.width,
                      height: videoController.value.size.height,
                      child: VideoPlayer(videoController),
                    ),
                  ),
                ),
              );
            } else {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  controller.getCurrentMovie()!.poster.url,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 200,
                  fit: BoxFit.cover,
                ),
              );
            }
          }),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.transparent],
              ),
            ),
          ),
          Column(
            children: [
              Expanded(child: Container()),
              MoviePosterHeader(),
              MoviePosterFooter(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _loadingEffect(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [AppTheme.backgroundColor, AppTheme.primaryDarkColor],
      ),
      child: Container(
        height: MediaQuery.of(context).size.height - 200,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(children: [Expanded(child: MoviePosterFooter())]),
      ),
    );
  }
}
