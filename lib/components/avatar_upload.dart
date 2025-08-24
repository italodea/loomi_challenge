import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_icons.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class AvatarUpload extends StatelessWidget {
  const AvatarUpload({super.key, this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: imagePath != null
                ? FileImage(File(imagePath!), scale: 1.0)
                : null,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: AppTheme.primaryDarkColor,
                padding: EdgeInsets.zero,
              ),
              icon: AppIcons.icon(AppIcons.camera),
            ),
          ),
        ],
      ),
    );
  }
}
