import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get getHeight => MediaQuery.of(this).size.height;
  double get getWidth => MediaQuery.of(this).size.width;

  EdgeInsets get paddingAllLow => const EdgeInsets.all(8);
  EdgeInsets get paddingAllMedium => const EdgeInsets.all(16);
  EdgeInsets get paddingAllHigh => const EdgeInsets.all(32);

  EdgeInsets get paddingHorizontalLow => const EdgeInsets.symmetric(horizontal: 8);
  EdgeInsets get paddingHorizontalMedium => const EdgeInsets.symmetric(horizontal: 16);
  EdgeInsets get paddingHorizontalHigh => const EdgeInsets.symmetric(horizontal: 32);

  EdgeInsets get paddingVerticalLow => const EdgeInsets.symmetric(vertical: 8);
  EdgeInsets get paddingVerticalMedium => const EdgeInsets.symmetric(vertical: 16);
  EdgeInsets get paddingVerticalHigh => const EdgeInsets.symmetric(vertical: 32);

  EdgeInsets paddingSymetricSpecific(double vValue, double hValue) => EdgeInsets.symmetric(horizontal: hValue, vertical: vValue);
  EdgeInsets paddingOnlyLeft(double vLeft) => EdgeInsets.only(left: vLeft);
  EdgeInsets paddingOnlyRight(double vRight) => EdgeInsets.only(right: vRight);
  EdgeInsets paddingOnlyBottom(double vBottom) => EdgeInsets.only(bottom: vBottom);
  EdgeInsets paddingOnlyTop(double vTop) => EdgeInsets.only(top: vTop);
}
