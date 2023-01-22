import 'package:flutter/material.dart';

import '../core/components/circular_button_atom.dart';

class NextSongButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final double size;

  const NextSongButtonWidget({Key? key, required this.onTap, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularButtonAtom(
      size: size,
      icon: Icon(Icons.skip_next),
      onTap: onTap,
    );
  }
}
