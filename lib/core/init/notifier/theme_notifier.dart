import 'package:flutter/material.dart';
import 'package:music_player/core/cache/app_shared_pref.dart';

import '../theme/app_theme_dark.dart';
import '../theme/app_theme_light.dart';

enum AppTheme { LIGHT, DARK }

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeLight.instance.theme;
  ThemeData get currentTheme => _currentTheme;

  ThemeNotifier() {
    getPrefTheme();
  }

  void changeTheme(AppTheme theme) {
    if (theme == AppTheme.LIGHT) {
      _currentTheme = AppThemeLight.instance.theme;
    } else {
      _currentTheme = AppThemeDark.instance.theme;
    }
    savePrefTheme();
    notifyListeners();
  }

  bool isThemeLight() => _currentTheme == AppThemeLight.instance.theme ? true : false;

  savePrefTheme() async {
    await AppSharedPreferences.instance.setString("theme", isThemeLight() ? "light" : "dark");
  }

  getPrefTheme() {
    if (AppSharedPreferences.instance.getString("theme") == null || AppSharedPreferences.instance.getString("theme") == "light") {
      changeTheme(AppTheme.LIGHT);
    } else {
      changeTheme(AppTheme.DARK);
    }
  }
}
