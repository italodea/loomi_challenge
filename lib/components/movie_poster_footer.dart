import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:loomi_chalenge/components/custom_divider.dart';
import 'package:loomi_chalenge/components/custom_icon_button.dart';
import 'package:loomi_chalenge/controllers/home_controller.dart';
import 'package:loomi_chalenge/themes/app_icons.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';
import 'package:share_plus/share_plus.dart';

class MoviePosterFooter extends StatefulWidget {
  const MoviePosterFooter({super.key});

  @override
  State<MoviePosterFooter> createState() => _MoviePosterFooterState();
}

class _MoviePosterFooterState extends State<MoviePosterFooter> {
  final HomeController controller = Get.find<HomeController>();

  String get formattedEndDate {
    if (controller.getCurrentMovie()?.endDate == null) return '????';
    try {
      final date = DateTime.parse(controller.getCurrentMovie()!.endDate.toString());
      return DateFormat("MMM dd, yyyy").format(date);
    } catch (_) {
      return '???';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          child: Row(
            children: [
              CustomIconButton(
                label: "Rate",
                icon: AppIcons.icon(AppIcons.like, size: 20),
                minimumSize: const Size(40, 20),
                maximumSize: const Size(double.infinity, 50),
                onPressed: () {},
                backgroundColor: Colors.transparent,
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.only(top: 3.0),
                textStyle: AppTheme.textThemeSecondary.bodySmall,
              ),
              const SizedBox(width: 10),
              CustomIconButton(
                label: "Gift to someone?",
                icon: AppIcons.icon(AppIcons.send, size: 20),
                minimumSize: const Size(40, 20),
                maximumSize: const Size(double.infinity, 50),
                onPressed: () {
                  SharePlus.instance.share(
                    ShareParams(
                      text: 'Check out this movie: ${controller.getCurrentMovie()?.name ?? ''}',
                      title: 'Share'
                    )
                  );
                },
                backgroundColor: Colors.transparent,
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.only(top: 3.0),
                textStyle: AppTheme.textThemeSecondary.bodySmall,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Available until",
                    style: AppTheme.textThemeSecondary.labelLarge?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    formattedEndDate,
                    style: AppTheme.textThemeSecondary.titleMedium?.copyWith(
                      color: AppTheme.activeBorderColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
