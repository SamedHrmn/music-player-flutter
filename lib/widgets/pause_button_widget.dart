import 'package:flutter/material.dart';

import '../core/components/circular_button_atom.dart';

class PauseButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final double size;

  const PauseButtonWidget({Key? key, required this.onTap, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularButtonAtom(
      size: size,
      icon: const Icon(Icons.pause),
      onTap: onTap,
    );
  }
}
