import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppTheme.secondaryColor, thickness: 0.5)),
        if (text != null) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              text!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: AppTheme.secondaryColor),
            ),
          ),
          Expanded(
            child: Divider(color: AppTheme.secondaryColor, thickness: 0.5),
          ),
        ] else ...[
          Expanded(
            child: Divider(color: AppTheme.secondaryColor, thickness: 0.5),
          ),
        ],
      ],
    );
  }
}
