import 'package:flutter/material.dart';

import '../core/constants/size_constants.dart';

class CustomCircleAvatarWidget extends StatelessWidget {
  const CustomCircleAvatarWidget({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(SizeConstants.HIGH_VALUE),
      elevation: 3.0,
      child: CircleAvatar(
        child: new Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
        backgroundColor: color,
      ),
    );
  }
}
