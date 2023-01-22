import 'package:flutter/material.dart';

import '../constants/size_constants.dart';

extension SizeExtension on BuildContext {
  double get getHeight => MediaQuery.of(this).size.height;
  double get getWidth => MediaQuery.of(this).size.width;

  EdgeInsets get paddingAllLow => const EdgeInsets.all(SizeConstants.LOW_VALUE);
  EdgeInsets get paddingAllMedium => const EdgeInsets.all(SizeConstants.MEDIUM_VALUE);
  EdgeInsets get paddingAllHigh => const EdgeInsets.all(SizeConstants.HIGH_VALUE);

  EdgeInsets get paddingHorizontalLow => const EdgeInsets.symmetric(horizontal: SizeConstants.LOW_VALUE);
  EdgeInsets get paddingHorizontalMedium => const EdgeInsets.symmetric(horizontal: SizeConstants.MEDIUM_VALUE);
  EdgeInsets get paddingHorizontalHigh => const EdgeInsets.symmetric(horizontal: SizeConstants.HIGH_VALUE);

  EdgeInsets get paddingVerticalLow => const EdgeInsets.symmetric(vertical: SizeConstants.LOW_VALUE);
  EdgeInsets get paddingVerticalMedium => const EdgeInsets.symmetric(vertical: SizeConstants.MEDIUM_VALUE);
  EdgeInsets get paddingVerticalHigh => const EdgeInsets.symmetric(vertical: SizeConstants.HIGH_VALUE);

  EdgeInsets paddingSymetricSpecific(double vValue, double hValue) => EdgeInsets.symmetric(horizontal: hValue, vertical: vValue);
  EdgeInsets paddingOnlyLeft(vLeft) => EdgeInsets.only(left: vLeft);
  EdgeInsets paddingOnlyRight(vRight) => EdgeInsets.only(right: vRight);
  EdgeInsets paddingOnlyBottom(vBottom) => EdgeInsets.only(bottom: vBottom);
  EdgeInsets paddingOnlyTop(vTop) => EdgeInsets.only(top: vTop);
}
