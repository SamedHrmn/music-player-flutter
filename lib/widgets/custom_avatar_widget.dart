import 'package:flutter/material.dart';

import '../core/constants/size_constants.dart';

class CustomCircleAvatarWidget extends StatelessWidget {
  const CustomCircleAvatarWidget({Key key, this.color}) : super(key: key);

  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(SizeConstants.HIGH_VALUE),
      elevation: 3.0,
      child: CircleAvatar(
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
        backgroundColor: color,
      ),
    );
  }
}
