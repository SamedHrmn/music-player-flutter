import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppThemeLight extends IAppTheme {
  static AppThemeLight _instance;
  static AppThemeLight get instance {
    return _instance ??= AppThemeLight._init();
  }

  AppThemeLight._init();

  @override
  ThemeData get theme => ThemeData(
        fontFamily: 'OpenSans',
        colorScheme: _colorScheme(),
        brightness: Brightness.light,
        primaryColor: Color(0xfffeca90),
        primaryColorBrightness: Brightness.light,
        primaryColorLight: Color(0xffffe7cc),
        primaryColorDark: Color(0xff985101),
        accentColor: Color(0xfffd8602),
        accentColorBrightness: Brightness.light,
        canvasColor: Color(0xfffafafa),
        scaffoldBackgroundColor: Color(0xfffafafa),
        bottomAppBarColor: Color(0xffffffff),
        cardColor: Color(0xffffffff),
        dividerColor: Color(0x1f000000),
        highlightColor: Color(0x66bcbcbc),
        splashColor: Color(0x66c8c8c8),
        selectedRowColor: Color(0xfff5f5f5),
        unselectedWidgetColor: Color(0x8a000000),
        disabledColor: Color(0x61000000),
        buttonColor: Color(0xffe0e0e0),
        toggleableActiveColor: Color(0xffca6b02),
        secondaryHeaderColor: Color(0xfffff3e6),
        backgroundColor: Color(0xfffecf9a),
        dialogBackgroundColor: Color(0xffffffff),
        indicatorColor: Color(0xfffd8602),
        hintColor: Color(0x8a000000),
        errorColor: Color(0xffd32f2f),
      );

  _colorScheme() {
    return ColorScheme(
      primary: Color(0xfffeca90),
      primaryVariant: Color(0xff985101),
      secondary: Color(0xfffd8602),
      secondaryVariant: Color(0xff985101),
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
        headline1: TextStyle(fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        headline2: TextStyle(fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
        headline3: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w400,
        ),
        headline4: TextStyle(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        headline5: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        button: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
        caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        overline: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
      );
}
