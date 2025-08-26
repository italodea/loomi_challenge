import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/custom_text_button.dart';
import 'package:loomi_chalenge/components/custom_text_option.dart';
import 'package:loomi_chalenge/controllers/watch_movie_controller.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class PlayerConfig extends StatelessWidget {
  PlayerConfig({super.key});

  final WatchMovieController controller = Get.find<WatchMovieController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 56),
                Text("Audio", style: AppTheme.textThemeSecondary.labelLarge),
                SizedBox(height: 16),
                CustomTextOption(label: "English", selected: true),
                CustomTextOption(label: "Spanish"),
                CustomTextOption(label: "Portuguese"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 56),
                Text("Subtitle", style: AppTheme.textThemeSecondary.labelLarge),
                SizedBox(height: 16),
                CustomTextOption(label: "Off", selected: true),
                CustomTextOption(label: "English"),
                CustomTextOption(label: "Spanish"),
                CustomTextOption(label: "Portuguese"),
              ],
            ),
            CustomTextButton(
              label: "Close",
              onPressed: () {
                controller.toggleConfig();
              },
            ),
          ],
        ),
      ),
    );
  }
}
