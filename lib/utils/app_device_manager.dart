import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

final class AppDeviceManager {
  const AppDeviceManager._();

  static Future<int?> getAndroidSdkVersion() async {
    if (!Platform.isAndroid) return null;

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt;
  }
}
