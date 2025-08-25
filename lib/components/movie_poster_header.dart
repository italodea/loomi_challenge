import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/cutom_button.dart';
import 'package:loomi_chalenge/controllers/home_controller.dart';
import 'package:loomi_chalenge/repositories/models/data/movie.dart';
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
    Movie? movie = widget.controller.getCurrentMovie();
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie?.genre ?? '',
              style: AppTheme.textThemeSecondary.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              movie?.name ?? '',
              style: AppTheme.textThemePrimary.headlineLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              movie?.synopsis ?? '',
              style: AppTheme.textThemeSecondary.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 20),
            Text(
              "Comments: ${movie?.id ?? 0}",
              style: AppTheme.textThemeSecondary.displaySmall,
            ),
            SizedBox(height: 10),
            Center(
              child: CustomButton(
                label: "Watch",
                onPressed: () async {},
                opacity: 150,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
