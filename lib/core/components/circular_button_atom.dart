import 'package:flutter/material.dart';

import 'package:music_player/core/constants/color_constants.dart';

class CircularButtonAtom extends StatelessWidget {
  const CircularButtonAtom({required this.icon, required this.onTap, required this.size, super.key});
  final Widget icon;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: size * 0.10, maxWidth: size * 0.15, minHeight: size * 0.10, maxHeight: size * 0.15),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          backgroundColor: ColorConstants.primary,
          child: icon,
        ),
      ),
    );
  }
}
