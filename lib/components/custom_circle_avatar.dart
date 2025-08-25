import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatefulWidget {
  const CustomCircleAvatar({super.key});

  @override
  State<CustomCircleAvatar> createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage("https://static.wixstatic.com/media/3d5dc1_f7d76270e09c4ca9b53aedc8030160d9.jpg/v1/fit/w_500,h_500,q_90/file.jpg"),
    );
  }
}