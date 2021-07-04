import 'package:flutter/material.dart';

import '../core/components/circular_button_atom.dart';

class PauseButtonWidget extends StatelessWidget {
  final Function onTap;

  const PauseButtonWidget({Key key, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularButtonAtom(
      icon: Icon(Icons.pause),
      onTap: onTap,
    );
  }
}
