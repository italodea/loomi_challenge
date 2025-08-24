import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class CustomSocialIconGoogle extends StatefulWidget {
  const CustomSocialIconGoogle({super.key, this.onPressed});

  final Future<void> Function()? onPressed;

  @override
  State<CustomSocialIconGoogle> createState() => _CustomSocialIconGoogleState();
}

class _CustomSocialIconGoogleState extends State<CustomSocialIconGoogle> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('assets/img/google_logo.png', width: 30, height: 30),
      style: IconButton.styleFrom(
        backgroundColor: AppTheme.primaryDarkColor,
        padding: EdgeInsets.all(15),
      ),
      onPressed: () async {
        if (_isLoading) return;
        setState(() {
          _isLoading = true;
        });
        try {
          await widget.onPressed?.call();
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.toString())));
        }
        setState(() {
          _isLoading = false;
        });
      },
    );
  }
}
