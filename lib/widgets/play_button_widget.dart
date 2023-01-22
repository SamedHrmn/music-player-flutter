import 'package:flutter/material.dart';

import '../core/components/circular_button_atom.dart';

class PlayButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final double size;
  const PlayButtonWidget({Key? key, required this.onTap, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularButtonAtom(
      size: size,
      icon: Icon(Icons.play_arrow),
      onTap: onTap,
    );
  }
}
