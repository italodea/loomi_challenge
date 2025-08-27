import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class CustomCircleAvatar extends StatefulWidget {
  const CustomCircleAvatar({super.key, this.imageUrl, required this.userName, this.maxRadius = 20});

  final String? imageUrl;
  final String userName;
  final int maxRadius;
  @override
  State<CustomCircleAvatar> createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: widget.maxRadius.toDouble(),
      backgroundColor:
          AppTheme.listProfileColors[(widget.userName.length) %
              AppTheme.listProfileColors.length],
      child: widget.imageUrl == null
          ? Text(
              widget.userName.isNotEmpty
                  ? widget.userName[0].toUpperCase()
                  : "U",
              style: AppTheme.textThemeSecondary.displayLarge,
            )
          : ClipOval(
              child: Image.network(
                widget.imageUrl!,
                width: widget.maxRadius * 2.toDouble(),
                height: widget.maxRadius * 2.toDouble(),
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
