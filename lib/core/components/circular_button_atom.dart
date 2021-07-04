import 'package:flutter/material.dart';

class CircularButtonAtom extends StatelessWidget {
  final Widget icon;
  final Function onTap;

  const CircularButtonAtom({Key key, @required this.icon, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        child: icon,
      ),
    );
  }
}
