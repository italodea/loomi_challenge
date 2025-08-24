import 'package:flutter/material.dart';

class AnimatedDot extends StatelessWidget {
  const AnimatedDot({
    super.key,
    required this.controller,
    required this.index,
    required this.radius,
    required this.color,
    required this.totalDots,
  });

  final AnimationController controller;
  final int index;
  final double radius;
  final Color color;
  final int totalDots;


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        double t = (controller.value + index / totalDots) % 1.0;
        return Transform.translate(
          offset: Offset(0, -radius * 2 * (0.5 - (t - 0.5).abs())),
          child: child,
        );
      },
      child: CircleAvatar(radius: radius, backgroundColor: color),
    );
  }
}
