import 'package:flutter/material.dart';
import 'package:loomi_chalenge/components/custom_icon_button.dart';
import 'package:loomi_chalenge/themes/app_icons.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class UploadImageComponent extends StatelessWidget {
  const UploadImageComponent({
    super.key,
    required this.onTap,
    required this.imagePath,
  });

  final void Function() onTap;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: InkWell(
        onTap: onTap,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Row(
          children: [
            CustomIconButton(
              icon: AppIcons.icon(AppIcons.camera),
              onPressed: () {
                onTap();
              },
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHOOSE IMAGE',
                    style: AppTheme.textThemeSecondary.labelLarge,
                  ),
                  Text(
                    'A square .jpg, .gif, or .png image 200x200 or larger',
                    style: AppTheme.textThemeSecondary.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
