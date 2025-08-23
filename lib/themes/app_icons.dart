import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const String camera = 'assets/icons/cam.svg';
  static const String gallery = 'assets/icons/gallery.svg';

  static Widget icon(
    String assetPath, {
    double size = 24.0,
    Color? color,
    BoxFit fit = BoxFit.contain,
    Key? key,
    String? semanticLabel,
  }) {
    return SvgPicture.asset(
      assetPath,
      key: key,
      width: size,
      height: size,
      fit: fit,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      semanticsLabel: semanticLabel,
    );
  }
}