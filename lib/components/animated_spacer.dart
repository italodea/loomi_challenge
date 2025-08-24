import 'package:flutter/material.dart';

class AnimatedSpacer extends StatelessWidget {
  const AnimatedSpacer({super.key, required this.beginHeight, required this.endHeight});

  final double beginHeight;
  final double endHeight;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: beginHeight, end: endHeight),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return SizedBox(height: value);
      },
    );
  }
}
