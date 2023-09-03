import 'package:flutter/material.dart';
import 'package:music_player/core/constants/color_constants.dart';

class AppText extends StatelessWidget {
  const AppText({super.key, required this.text, this.size, this.fontWeight, this.maxLines, this.color, this.textAlign});

  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final int? maxLines;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'EvilEmpire',
        fontSize: size,
        fontWeight: fontWeight,
        color: color ?? ColorConstants.primary,
      ),
      maxLines: maxLines,
    );
  }
}
