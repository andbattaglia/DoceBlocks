import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final ThemeData kLightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Color(0xFF3366ff),
    accentColor: Color(0x59000000),
    primaryColorDark:  Color(0xFF003dcb),
    primaryColorLight:  Color(0xFF7b93ff),
    buttonColor: Color(0xFF3366ff),
    selectedRowColor: Color(0xFFDADADA),
    iconTheme: new IconThemeData(
        color: Colors.white,
        opacity: 1.0
    ),
    accentIconTheme: new IconThemeData(
        color: Color(0xFF000000),
        opacity: 1.0
    ),
    primaryIconTheme: new IconThemeData(
        color: Color(0xFF3366ff),
        opacity: 1.0
    ),
    textTheme: _buildTextTheme(Colors.black87),
    accentTextTheme: _buildTextTheme(Colors.white),
    primaryTextTheme: _buildTextTheme(Color(0xFF3366ff))
  );
}

final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: Color(0xFF3366ff),
    accentColor: Color(0x59000000),
    primaryColorDark:  Color(0xFF003dcb),
    primaryColorLight:  Color(0xFF7b93ff),
    buttonColor: Color(0xFF3366ff),
    selectedRowColor: Color(0xFF757575),
    iconTheme: new IconThemeData(
        color: Colors.white,
        opacity: 1.0
    ),
    accentIconTheme: new IconThemeData(
        color: Colors.white,
        opacity: 1.0
    ),
    primaryIconTheme: new IconThemeData(
        color: Color(0xFF3366ff),
        opacity: 1.0
    ),
    textTheme: _buildTextTheme(Colors.white),
    accentTextTheme: _buildTextTheme(Colors.white),
    primaryTextTheme: _buildTextTheme(Color(0xFF3366ff))
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