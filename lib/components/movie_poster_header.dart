import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/cutom_button.dart';
import 'package:loomi_chalenge/components/loading_effect.dart';
import 'package:loomi_chalenge/controllers/home_controller.dart';
import 'package:loomi_chalenge/repositories/models/data/movie.dart';
import 'package:loomi_chalenge/routes/app_routes.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class MoviePosterHeader extends StatefulWidget {
  MoviePosterHeader({super.key});

  final HomeController controller = Get.find<HomeController>();
  @override
  State<MoviePosterHeader> createState() => _MoviePosterHeaderState();
}

class _MoviePosterHeaderState extends State<MoviePosterHeader> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Movie? movie = widget.controller.getCurrentMovie();
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadingEffect(
                        loaded: widget.controller.getCurrentMovie() != null,
                        width: MediaQuery.of(context).size.width - 300,
                        child: Text(
                          movie?.genre ?? '',
                          style: AppTheme.textThemeSecondary.displayMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      LoadingEffect(
                        loaded: widget.controller.getCurrentMovie() != null,
                        width: MediaQuery.of(context).size.width - 250,
                        child: Text(
                          movie?.name ?? '',
                          style: AppTheme.textThemePrimary.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  MediaQuery.of(context).size.height <= 400 ? Center(
                    child: LoadingEffect(
                      loaded: widget.controller.getCurrentMovie() != null,
                      child: CustomButton(
                        label: "Watch",
                        onPressed: () async {
                          if (widget.controller.getCurrentMovie() != null) {
                            Get.toNamed(
                              AppRoutes.watchMovie,
                              arguments: widget.controller.getCurrentMovie(),
                            );
                          }
                        },
                        opacity: 150,
                      ),
                    ),
                  ) : Container(),
                ],
              ),
              SizedBox(height: 8),
              MediaQuery.of(context).size.height > 400 ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadingEffect(
                    loaded: widget.controller.getCurrentMovie() != null,
                    width: MediaQuery.of(context).size.width - 40,
                    child: Text(
                      movie?.synopsis ?? '',
                      style: AppTheme.textThemeSecondary.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 20),
                  LoadingEffect(
                    loaded: widget.controller.getCurrentMovie() != null,
                    child: Text(
                      "Comments: ${movie?.id ?? 0}",
                      style: AppTheme.textThemeSecondary.displaySmall,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: LoadingEffect(
                      loaded: widget.controller.getCurrentMovie() != null,
                      child: CustomButton(
                        label: "Watch",
                        onPressed: () async {
                          if (widget.controller.getCurrentMovie() != null) {
                            Get.toNamed(
                              AppRoutes.watchMovie,
                              arguments: widget.controller.getCurrentMovie(),
                            );
                          }
                        },
                        opacity: 150,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ) : Container(),
            ],
          ),
        ),
      );
    });
  }
}
