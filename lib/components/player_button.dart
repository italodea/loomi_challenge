import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_icons.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class PlayerButton extends StatelessWidget {
  const PlayerButton({
    super.key,
    required this.icon,
    this.label,
    required this.onPressed,
    this.size = 30,
    this.color = AppTheme.textColor,
  });
  final String icon;
  final double size;
  final String? label;
  final Color? color;
  final Future<void> Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          AppIcons.icon(icon, size: size, color: color),
          if (label != null) ...[
            SizedBox(width: 8),
            Text(label!, style: AppTheme.textThemeSecondary.displaySmall),
          ],
        ],
      ),
    );
  }
}
