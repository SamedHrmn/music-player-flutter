import 'dart:developer';
import 'package:music_player/core/constants/string_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HelperFunctions {
  static String parseToMinutesSeconds(int ms) {
    String data;
    final duration = Duration(milliseconds: ms);

    final minutes = duration.inMinutes;
    final seconds = (duration.inSeconds) - (minutes * 60);

    data = '$minutes:';
    if (seconds <= 9) data += '0';

    return data += seconds.toString();
  }

  static Future<void> openPrivacyPolicyUrl() async {
    try {
      await launchUrl(Uri.parse(StringConstants.privacyPolicyUrl));
    } catch (e) {
      log(e.toString());
    }
  }
}
