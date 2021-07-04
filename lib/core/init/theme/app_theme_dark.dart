import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppThemeDark extends IAppTheme {
  static AppThemeDark _instance;
  static AppThemeDark get instance {
    return _instance ??= AppThemeDark._init();
  }

  AppThemeDark._init();

  @override
  ThemeData get theme => ThemeData(
        fontFamily: 'OpenSans',
        textTheme: textTheme,
        colorScheme: _colorScheme(),
        brightness: Brightness.dark,
        primaryColor: Color(0xFF2E2E2E),
        primaryColorBrightness: Brightness.dark,
        primaryColorLight: Color(0xff9e9e9e),
        primaryColorDark: Color(0xff000000),
        accentColor: Color(0xff64ffda),
        accentColorBrightness: Brightness.light,
        canvasColor: Color(0xff303030),
        scaffoldBackgroundColor: Color(0xFF1D1D1D),
        bottomAppBarColor: Color(0xff424242),
        cardColor: Color(0xff424242),
        dividerColor: Color(0x1fffffff),
        highlightColor: Color(0x40cccccc),
        splashColor: Color(0x40cccccc),
        selectedRowColor: Color(0xfff5f5f5),
        unselectedWidgetColor: Color(0xb3ffffff),
        disabledColor: Color(0x62ffffff),
        buttonColor: Color(0xff4e517e),
        toggleableActiveColor: Color(0xff64ffda),
        secondaryHeaderColor: Color(0xff616161),
        backgroundColor: Color(0xff616161),
        dialogBackgroundColor: Color(0xff424242),
        indicatorColor: Color(0xff64ffda),
        hintColor: Color(0x80ffffff),
        errorColor: Color(0xffd32f2f),
      );

  _colorScheme() {
    return ColorScheme(
      primary: Color(0xff212235),
      primaryVariant: Color(0xff000000),
      secondary: Color(0xff64ffda),
      secondaryVariant: Color(0xff00bfa5),
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
