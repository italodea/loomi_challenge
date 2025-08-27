
import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_icons.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class ExpandedButton extends StatelessWidget {
  const ExpandedButton({super.key, required this.onPressed, this.icon, this.label, this.prefix, this.child, this.suffix});

  final VoidCallback onPressed;
  final String? icon;
  final String? label;
  final Widget? prefix;
  final Widget? child;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.darker,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            prefix ?? AppIcons.icon(icon ?? AppIcons.backward),
            SizedBox(width: 12,),
            child ?? Text(
              label ?? "",
              style: AppTheme.textThemeSecondary.displayMedium,
            ),
            Expanded(child: SizedBox(width: 12,)),
            suffix ?? Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20,)
          ],
        ),
      ),
    );
  }
}