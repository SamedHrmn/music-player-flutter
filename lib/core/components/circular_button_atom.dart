import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CircularButtonAtom extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  final double size;

  const CircularButtonAtom({Key? key, required this.icon, required this.onTap, required this.size}) : super(key: key);

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
