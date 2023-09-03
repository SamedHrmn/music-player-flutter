import 'package:flutter/material.dart';
import 'package:music_player/core/constants/color_constants.dart';

import '../core/components/circular_button_atom.dart';

class NextSongButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final double size;

  const NextSongButtonWidget({Key? key, required this.onTap, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularButtonAtom(
      size: size,
      icon: const Icon(Icons.skip_next, color: ColorConstants.primaryLight),
      onTap: onTap,
    );
  }
}
