import 'package:flutter/material.dart';
import 'package:search_islam/utill/color_resources.dart';

ThemeData light=ThemeData(
  fontFamily: 'Poppins',
  primaryColor: Colors.white,
  brightness: Brightness.light,
  accentColor: ColorResources().mainColor(1),
  focusColor: ColorResources().accentColor(1),
  hintColor: ColorResources().secondColor(1),
  textTheme: TextTheme(
    button: TextStyle(color: Colors.white),
    headline5: TextStyle(fontSize: 20.0, color: ColorResources().secondColor(1)),
    headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: ColorResources().secondColor(1)),
    headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: ColorResources().secondColor(1)),
    headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: ColorResources().mainColor(1)),
    headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: ColorResources().secondColor(1)),
    subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: ColorResources().secondColor(1)),
    headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorResources().mainColor(1)),
    bodyText2: TextStyle(fontSize: 12.0, color: ColorResources().secondColor(1)),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: ColorResources().secondColor(1)),
    caption: TextStyle(fontSize: 12.0, color: ColorResources().secondColor(0.6)),
  ),
);

ThemeData dark=ThemeData(
  fontFamily: 'Poppins',
  primaryColor: Color(0xFF252525),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF2C2C2C),
  accentColor: ColorResources().mainDarkColor(1),
  hintColor: ColorResources().secondDarkColor(1),
  focusColor: ColorResources().accentDarkColor(1),
  textTheme: TextTheme(
    button: TextStyle(color: Color(0xFF252525)),
    headline5: TextStyle(fontSize: 20.0, color: ColorResources().secondDarkColor(1)),
    headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: ColorResources().secondDarkColor(1)),
    headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: ColorResources().secondDarkColor(1)),
    headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: ColorResources().mainDarkColor(1)),
    headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: ColorResources().secondDarkColor(1)),
    subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: ColorResources().secondDarkColor(1)),
    headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorResources().mainDarkColor(1)),
    bodyText2: TextStyle(fontSize: 12.0, color: ColorResources().secondDarkColor(1)),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: ColorResources().secondDarkColor(1)),
    caption: TextStyle(fontSize: 12.0, color: ColorResources().secondDarkColor(0.7)),
  ),
);