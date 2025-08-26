import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class LoadingEffect extends StatelessWidget {
  const LoadingEffect({super.key, required this.loaded, required this.child, this.height, this.width});
  final bool loaded;
  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return loaded ? child :  SizedBox(
      height: height,
      width: width,
      child: Shimmer(
        gradient: LinearGradient(
          colors: [AppTheme.backgroundInputColor, AppTheme.secondaryDarkColor],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: loaded ? Colors.transparent : Colors.grey[300],
          ),
          child: child,
        ),
      ),
    );
  }
}