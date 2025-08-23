import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class CustomSocialIconApple extends StatelessWidget {
  const CustomSocialIconApple({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/img/apple_logo.png',
        width: 30,
        height: 30,
      ),
      style: IconButton.styleFrom(
        backgroundColor: AppTheme.secondaryDarkColor,
        padding: EdgeInsets.all(15),
      ),
      onPressed: () {
      },
    );
  }
}