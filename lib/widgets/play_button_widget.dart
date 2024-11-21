import 'package:flutter/material.dart';
import 'package:music_player/core/components/circular_button_atom.dart';
import 'package:music_player/core/constants/color_constants.dart';

class PlayButtonWidget extends StatelessWidget {
  const PlayButtonWidget({required this.onTap, required this.size, super.key});
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircularButtonAtom(
      size: size,
      icon: const Icon(Icons.play_arrow, color: ColorConstants.primaryLight),
      onTap: onTap,
    );
  }
}
