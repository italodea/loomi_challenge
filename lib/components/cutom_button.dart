import 'package:flutter/material.dart';
import 'package:loomi_chalenge/components/dot_loading_indicator.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, required this.label, required this.onPressed});
  final String label;
  final Future<void> Function() onPressed;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
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
