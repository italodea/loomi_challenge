import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    super.key,
    this.icon,
    this.onPressed,
    this.backgroundColor,
    this.minimumSize,
    this.label,
    this.border, // Add this line
  });
  final Widget? icon;
  final String? label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Size? minimumSize;
  final BorderSide? border; // Add this line

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon ?? Icon(Icons.add),
            if (widget.label != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.label!,
                  style: AppTheme.textThemeSecondary.bodyLarge!.copyWith(
                    color: AppTheme.textColorDark,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
          ],
        ),
      ),
      style: IconButton.styleFrom(
        backgroundColor: widget.backgroundColor ?? AppTheme.primaryDarkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: widget.border ?? BorderSide.none, // Use custom border
        ),
        minimumSize: widget.minimumSize ?? Size(150, 150),
        maximumSize: Size(150, 150),
      ),
      onPressed: widget.onPressed,
    );
  }
}
