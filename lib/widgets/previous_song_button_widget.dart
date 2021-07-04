import 'package:flutter/material.dart';

import '../core/components/circular_button_atom.dart';

class PreviousSongButtonWidget extends StatelessWidget {
  final Function onTap;

  const PreviousSongButtonWidget({Key key, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularButtonAtom(
      icon: Icon(Icons.skip_previous),
      onTap: onTap,
    );
  }
}
