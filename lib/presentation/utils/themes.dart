import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final ThemeData kLightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Color(0xFF00D8FF),
    accentColor: Color(0x59000000),
    primaryColorDark:  Color(0xFF00a6cc),
    primaryColorLight:  Color(0xFF6dffff),
    buttonColor: Color(0xFF00D8FF),
    backgroundColor: Color(0xFFFFFFFF),
    selectedRowColor: Colors.grey[300],
    iconTheme: new IconThemeData(
        color: Colors.white,
        opacity: 1.0
    ),
    primaryIconTheme: new IconThemeData(
        color: Colors.black,
        opacity: 1.0
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
        color: Colors.grey[300]
    ) ,
    textTheme: _buildTextTheme(Colors.black87),
    accentTextTheme: _buildTextTheme(Colors.white),
  );
}

final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: Color(0xFFf2a365),
    accentColor: Color(0x59000000),
    primaryColorDark:  Color(0xFFbc7438),
    primaryColorLight:  Color(0xFFffd494),
    buttonColor: Color(0xFFf2a365),
    iconTheme: new IconThemeData(
        color: Colors.white,
        opacity: 1.0
    ),
    selectedRowColor: Colors.grey[500],
    primaryIconTheme: new IconThemeData(
        color: Colors.white,
        opacity: 1.0
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
        color: Colors.grey[700]
    ),
    textTheme: _buildTextTheme(Colors.white),
    accentTextTheme: _buildTextTheme(Colors.white)
  );
}

TextTheme _buildTextTheme(Color color) {
  return TextTheme(
    headline1: TextStyle(fontSize: 96.0, fontWeight: FontWeight.w300, letterSpacing: -1.5, color: color),
    headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w300, letterSpacing: -0.5, color: color),
    headline3: TextStyle(fontSize: 49.0, fontWeight: FontWeight.w400, letterSpacing: 0, color: color),
    headline4: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: color),
    headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, letterSpacing: 0, color: color),
    headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: color),
    subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.15, color: color),
    subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: color),
    bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.5, color: color),
    bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: color),
    button: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 1.25, color: color),
  );
}