import 'package:flutter/material.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class CustomCircleAvatar extends StatefulWidget {
  const CustomCircleAvatar({super.key, this.imageUrl, required this.userName});

  final String? imageUrl;
  final String userName;

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
      maxRadius: 20,
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
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
