import 'package:music_player/locator.dart';

final class AppInitializer {
  const AppInitializer._();

  static Future<void> setupDependencies() async {
    await setupLocator();
  }
}
