import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themes{
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blue,
  );
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
  );
}

class ThemeNotifier extends ChangeNotifier {
  bool _darkTheme = false;
  SharedPreferences? _preferences;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _loadSettingsFromPrefs();
  }

  _initializePrefs() async {
    // if (_preferences == null){
    _preferences ??= await SharedPreferences.getInstance();
  }

  _loadSettingsFromPrefs() async {
    await _initializePrefs();
    _darkTheme = _preferences?.getBool('darkTheme') ?? false;
    notifyListeners();
  }

  _saveSettingsToPrefs() async {
    await _initializePrefs();
    _preferences?.setBool('darkTheme', _darkTheme);
  }

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveSettingsToPrefs();
    notifyListeners();
  }
}