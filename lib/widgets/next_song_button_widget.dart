import 'package:flutter/material.dart';

import '../core/components/circular_button_atom.dart';

class NextSongButtonWidget extends StatelessWidget {
  final Function onTap;

  const NextSongButtonWidget({Key key, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularButtonAtom(
      icon: Icon(Icons.skip_next),
      onTap: onTap,
    );
  }
}
