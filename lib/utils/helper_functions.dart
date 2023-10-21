import 'dart:developer';

import 'package:music_player/core/constants/string_constants.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: unused_import
import 'package:url_launcher/url_launcher_string.dart';

class HelperFunctions {
  static final HelperFunctions instance = HelperFunctions._init();

  HelperFunctions._init();

  factory HelperFunctions() {
    return instance;
  }

  parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = "$minutes:";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }

  Future<void> openPrivacyPolicyUrl() async {
    try {
      await launchUrl(Uri.parse(StringConstants.privacyPolicyUrl));
    } catch (e) {
      log(e.toString());
    }
  }
}
