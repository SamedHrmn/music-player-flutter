import 'package:flutter/material.dart';
import 'package:music_player/core/constants/color_constants.dart';

import '../core/components/circular_button_atom.dart';

class PreviousSongButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final double size;
  const PreviousSongButtonWidget({Key? key, required this.onTap, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularButtonAtom(
      size: size,
      icon: const Icon(Icons.skip_previous, color: ColorConstants.primaryLight),
      onTap: onTap,
    );
  }
}
