import 'package:flutter/material.dart';

import '../theme/app_theme_dark.dart';
import '../theme/app_theme_light.dart';

enum AppTheme { LIGHT, DARK }

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeLight.instance.theme;
  ThemeData get currentTheme => _currentTheme;

  void changeTheme(AppTheme theme) {
    if (theme == AppTheme.LIGHT) {
      _currentTheme = AppThemeLight.instance.theme;
    } else {
      _currentTheme = AppThemeDark.instance.theme;
    }

    notifyListeners();
  }

  bool isThemeLight() => _currentTheme == AppThemeLight.instance.theme ? true : false;
}
