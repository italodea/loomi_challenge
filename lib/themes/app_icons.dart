import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const String camera = 'assets/icons/cam.svg';
  static const String gallery = 'assets/icons/gallery.svg';
  static const String like = 'assets/icons/like.svg';
  static const String send = 'assets/icons/send.svg';
  static const String play = 'assets/icons/play.svg';
  static const String pause = 'assets/icons/pause.svg';
  static const String backward = 'assets/icons/backward_15.svg';
  static const String forward = 'assets/icons/forward_15.svg';
  static const String fullscreen = 'assets/icons/full_screen.svg';
  static const String subtitles = 'assets/icons/subtitles.svg';
  static const String flag = 'assets/icons/flag.svg';
  static const String trash = 'assets/icons/trash.svg';
  static const String report = 'assets/icons/report.svg';
  static const String comment = 'assets/icons/comment.svg';

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