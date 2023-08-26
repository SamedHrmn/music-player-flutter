import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppThemeLight extends IAppTheme {
  static AppThemeLight? _instance;
  static AppThemeLight get instance {
    return _instance ??= AppThemeLight._init();
  }

  AppThemeLight._init();

  @override
  ThemeData get theme => ThemeData(
        fontFamily: 'OpenSans',
        brightness: Brightness.light,
        primaryColor: const Color(0xfffeca90),
        primaryColorLight: const Color(0xffffe7cc),
        primaryColorDark: const Color(0xff985101),
        hintColor: const Color(0xfffd8602),
        canvasColor: const Color(0xfffafafa),
        scaffoldBackgroundColor: const Color(0xfffafafa),
        cardColor: const Color(0xffffffff),
        dividerColor: const Color(0x1f000000),
        highlightColor: const Color(0x66bcbcbc),
        splashColor: const Color(0x66c8c8c8),
        unselectedWidgetColor: const Color(0x8a000000),
        disabledColor: const Color(0x61000000),
        secondaryHeaderColor: const Color(0xfffff3e6),
        dialogBackgroundColor: const Color(0xffffffff),
        indicatorColor: const Color(0xfffd8602),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return const Color(0xffca6b02);
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
              return const Color(0xffca6b02);
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
              return const Color(0xffca6b02);
            }
            return null;
          }),
          trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return const Color(0xffca6b02);
            }
            return null;
          }),
        ),
        bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xffffffff)),
        colorScheme: _colorScheme().copyWith(background: const Color(0xfffecf9a)).copyWith(error: const Color(0xffd32f2f)),
      );

  _colorScheme() {
    return const ColorScheme(
      primary: Color(0xfffeca90),
      secondary: Color(0xfffd8602),
      surface: Color(0xffffffff),
      background: Color(0xfffecf9a),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xff000000),
      onSecondary: Color(0xff000000),
      onSurface: Color(0xff000000),
      onBackground: Color(0xff000000),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
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
