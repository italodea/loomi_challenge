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
    this.border,
    this.maximumSize,
    this.padding,
    this.margin,
    this.textStyle,
  });
  final Widget? icon;
  final String? label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Size? minimumSize;
  final Size? maximumSize;
  final BorderSide? border;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextStyle? textStyle;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Padding(
        padding: widget.margin ?? EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon ?? Icon(Icons.add),
            if (widget.label != null)
              Padding(
                padding: widget.padding ?? EdgeInsets.all(8.0),
                child: Text(
                  widget.label!,
                  style: widget.textStyle ?? AppTheme.textThemeSecondary.bodyLarge!.copyWith(
                    color: AppTheme.textDarkColor,
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
          side: widget.border ?? BorderSide.none,
        ),
        minimumSize: widget.minimumSize ?? Size(150, 150),
        maximumSize: widget.maximumSize ?? Size(150, 150),
      ),
      onPressed: widget.onPressed,
    );
  }
}
