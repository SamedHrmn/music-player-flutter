import 'dart:io';
import 'package:music_player/utils/app_device_manager.dart';
import 'package:permission_handler/permission_handler.dart';

final class AppPermissionManager {
  const AppPermissionManager._();

  static Future<void> askMediaPermission() async {
    final sdkInt = await AppDeviceManager.getAndroidSdkVersion();
    if (sdkInt != null) {
      if (sdkInt >= 33) {
        await Permission.audio.request();
      } else if (sdkInt < 33) {
        await Permission.storage.request();
      }
      return;
    }

    if (Platform.isIOS) {
      await Permission.mediaLibrary.request();
    }
  }

  static Future<bool> isGrantedMediaPermission() async {
    final sdkInt = await AppDeviceManager.getAndroidSdkVersion();
    if (sdkInt != null) {
      if (sdkInt >= 33) return Permission.audio.isGranted;
      return Permission.storage.isGranted;
    } else {
      if (Platform.isIOS) return Permission.mediaLibrary.isGranted;
    }
    return false;
  }
}
