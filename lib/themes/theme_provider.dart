import 'package:flutter/material.dart';
import 'package:music_app/themes/light_mode.dart';
import 'dark_mode.dart';


class ThemeProvider extends ChangeNotifier {
  // initially, light Mode
  ThemeData _themeData  = lightMode;

  // get theme
  ThemeData get themeData => _themeData;

  // is dark Mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set themeData(ThemeData theme) {
    _themeData = theme;

    // update UI
    notifyListeners();
  }

  void toggleTheme() {
    // if current theme is light mode, set dark mode
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      // else, set light mode
      _themeData = lightMode;
    }

    // update UI
    notifyListeners();
  }
}