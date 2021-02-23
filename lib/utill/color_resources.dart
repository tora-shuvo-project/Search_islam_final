import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/theme_provider.dart';

class ColorResources {
  static Color getPrimaryColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFFba4f41) : Color(0xFFFC6A57);
  }
  static Color getGreyColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF6f7275) : Color(0xFFA0A4A8);
  }
  static Color getGrayColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF919191) : Color(0xFF6E6E6E);
  }
  static Color getSearchBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF585a5c) : Color(0xFFF4F7FC);
  }
  static Color getBackgroundColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF343636) : Color(0xFFF4F7FC);
  }
  static Color getHintColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF98a1ab) : Color(0xFF52575C);
  }
  static Color getGreyBunkerColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF717b85) : Color(0xFF25282B);
  }

  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };

  static const MaterialColor PRIMARY_MATERIAL = MaterialColor(0xFF192D6B, colorMap);


  Color _mainColor = Color(0xFF009DB5);
  Color _mainDarkColor = Color(0xFF22B7CE);
  Color _secondColor = Color(0xFF04526B);
  Color _secondDarkColor = Color(0xFFE7F6F8);
  Color _accentColor = Color(0xFFADC4C8);
  Color _accentDarkColor = Color(0xFFADC4C8);

  Color mainColor(double opacity) {
    return this._mainColor.withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return this._secondColor.withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return this._accentColor.withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return this._mainDarkColor.withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return this._secondDarkColor.withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return this._accentDarkColor.withOpacity(opacity);
  }

}
