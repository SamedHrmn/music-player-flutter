import 'package:flutter/material.dart';

import 'package:music_player/core/constants/color_constants.dart';

class CircularButtonAtom extends StatelessWidget {
  const CircularButtonAtom({required this.icon, required this.onTap, this.size, super.key});
  final Widget icon;
  final VoidCallback onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: ColorConstants.wine,
        radius: size ?? 32,
        child: icon,
      ),
    );
  }
}
