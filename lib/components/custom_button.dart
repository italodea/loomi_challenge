import 'package:flutter/material.dart';
import 'package:loomi_chalenge/components/dot_loading_indicator.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, required this.label, required this.onPressed, this.opacity});
  final String label;
  final Future<void> Function() onPressed;
  final int? opacity;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: widget.opacity != null ? OutlinedButton.styleFrom(
        backgroundColor: AppTheme.primaryDarkColor.withAlpha(widget.opacity!),
      ) : null,
      onPressed: () async {
        if (_isLoading) return;
        setState(() {
          _isLoading = true;
        });
        try {
          await widget.onPressed();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
        setState(() {
          _isLoading = false;
        });
      },
      label: _isLoading ? DotLoadingIndicator() : Text(widget.label),
    );
  }


}
