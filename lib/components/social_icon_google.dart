import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class CustomSocialIconGoogle extends StatelessWidget {
  const CustomSocialIconGoogle({super.key, this.onPressed});

  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/img/google_logo.png',
        width: 30,
        height: 30,
      ),
      style: IconButton.styleFrom(
        backgroundColor: AppTheme.primaryDarkColor,
        padding: EdgeInsets.all(15),
      ),
      onPressed: onPressed,
    );
  }
}