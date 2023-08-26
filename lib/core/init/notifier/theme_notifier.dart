// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../../cache/app_shared_pref.dart';
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

  bool isThemeLight() => currentTheme.primaryColor == AppThemeLight.instance.theme.primaryColor ? true : false;

  savePrefTheme() async {
    await AppSharedPreferences.instance.setString("theme", isThemeLight() ? "light" : "dark");
  }

  getPrefTheme() {
    if (AppSharedPreferences.instance.getString("theme").isEmpty || AppSharedPreferences.instance.getString("theme") == "light") {
      changeTheme(AppTheme.LIGHT);
    } else {
      changeTheme(AppTheme.DARK);
    }
  }
}
