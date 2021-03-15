import 'package:flutter/foundation.dart';
import 'package:search_islam/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;

  ThemeProvider({@required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveCurrentTheme();
    notifyListeners();
  }

  _loadCurrentTheme() async {
    _darkTheme = sharedPreferences.getBool(AppConstants.THEME) ?? true;
    notifyListeners();
  }

  _saveCurrentTheme() async {
    sharedPreferences.setBool(AppConstants.THEME, _darkTheme);
  }
}
