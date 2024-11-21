import 'package:flutter/material.dart';

import 'package:music_player/core/components/circular_button_atom.dart';

class PauseButtonWidget extends StatelessWidget {
  const PauseButtonWidget({required this.onTap, required this.size, super.key});
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircularButtonAtom(
      size: size,
      icon: const Icon(Icons.pause),
      onTap: onTap,
    );
  }
}
