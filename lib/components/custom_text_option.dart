import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class CustomTextOption extends StatelessWidget {
  const CustomTextOption({
    super.key,
    required this.label,
    this.selected = false,
  });

  final String label;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: selected
            ? BoxDecoration(
                color: AppTheme.primaryDarkColor,
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Text(
          label,
          style: AppTheme.textThemeSecondary.displayMedium!.copyWith(
            color: selected ? AppTheme.primaryColor : AppTheme.secondaryColor,
          ),
        ),
      ),
    );
  }
}
