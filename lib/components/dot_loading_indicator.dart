import 'package:flutter/material.dart';
import 'package:loomi_chalenge/components/animated_dot.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class DotLoadingIndicator extends StatefulWidget {
  final double dotRadius;
  final double spacing;
  final int dotCount;
  final Duration duration;

  const DotLoadingIndicator({
    super.key,
    this.dotRadius = 4.0,
    this.spacing = 8.0,
    this.dotCount = 3,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<DotLoadingIndicator> createState() => _DotLoadingIndicatorState();
}

class _DotLoadingIndicatorState extends State<DotLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.dotRadius * 2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.dotCount, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
            child: AnimatedDot(
              controller: _controller,
              index: index,
              radius: widget.dotRadius,
              color: AppTheme.primaryColor,
              totalDots: widget.dotCount,
            ),
          );
        }),
      ),
    );
  }
}
