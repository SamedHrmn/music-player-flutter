import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppThemeDark extends IAppTheme {
  static AppThemeDark? _instance;
  static AppThemeDark get instance {
    return _instance ??= AppThemeDark._init();
  }

  AppThemeDark._init();

  @override
  ThemeData get theme => ThemeData(
        fontFamily: 'OpenSans',
        textTheme: textTheme,
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF2E2E2E),
        primaryColorLight: const Color(0xff9e9e9e),
        primaryColorDark: const Color(0xff000000),
        canvasColor: const Color(0xff303030),
        scaffoldBackgroundColor: const Color(0xFF1D1D1D),
        cardColor: const Color(0xff424242),
        dividerColor: const Color(0x1fffffff),
        highlightColor: const Color(0x40cccccc),
        splashColor: const Color(0x40cccccc),
        unselectedWidgetColor: const Color(0xb3ffffff),
        disabledColor: const Color(0x62ffffff),
        secondaryHeaderColor: const Color(0xff616161),
        dialogBackgroundColor: const Color(0xff424242),
        indicatorColor: const Color(0xff64ffda),
        hintColor: const Color(0x80ffffff),
        bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xff424242)),
        colorScheme: _colorScheme().copyWith(secondary: const Color(0xff64ffda)).copyWith(error: const Color(0xffd32f2f)).copyWith(background: const Color(0xff616161)),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return const Color(0xff64ffda);
            }
            return null;
          }),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return const Color(0xff64ffda);
            }
            return null;
          }),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return const Color(0xff64ffda);
            }
            return null;
          }),
          trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return const Color(0xff64ffda);
            }
            return null;
          }),
        ),
      );

  _colorScheme() {
    return const ColorScheme(
      primary: Color(0xff212235),
      secondary: Color(0xff64ffda),
      surface: Color(0xff424242),
      background: Color(0xff616161),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xff000000),
      onSurface: Color(0xffffffff),
      onBackground: Color(0xffffffff),
      onError: Color(0xff000000),
      brightness: Brightness.dark,
    );
  }

  @override
  TextTheme get textTheme => ThemeData.light().textTheme.copyWith(
        displayLarge: const TextStyle(fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        displayMedium: const TextStyle(fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
        displaySmall: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: const TextStyle(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        headlineSmall: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        titleSmall: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        bodyLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
        bodySmall: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        labelSmall: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
      );
}
