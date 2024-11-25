import 'package:get_it/get_it.dart';
import 'package:music_player/core/cache/app_shared_pref.dart';
import 'package:music_player/core/navigation/app_navigation_manager.dart';
import 'package:music_player/utils/app_audio_control_manager.dart';
import 'package:music_player/utils/app_audio_query_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt
    ..registerSingleton<AppNavigationManager>(AppNavigationManager())
    ..registerSingleton<AppAudioQueryManager>(AppAudioQueryManager())
    ..registerSingleton<AppAudioControlManager>(AppAudioControlManager())
    ..registerLazySingletonAsync<AppSharedPreferences>(
      () async {
        final sharedPref = await SharedPreferences.getInstance();
        return AppSharedPreferences(sharedPref);
      },
    );
}
