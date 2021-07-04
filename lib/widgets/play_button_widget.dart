import 'package:flutter/material.dart';

import '../core/components/circular_button_atom.dart';

class PlayButtonWidget extends StatelessWidget {
  final Function onTap;

  const PlayButtonWidget({Key key, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularButtonAtom(
      icon: Icon(Icons.play_arrow),
      onTap: onTap,
    );
  }
}
