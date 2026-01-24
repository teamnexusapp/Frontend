import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;

  ThemeProvider({ThemeMode initialMode = ThemeMode.system}) : _mode = initialMode;

  Future<void> setMode(ThemeMode mode) async {
    _mode = mode;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = mode == ThemeMode.system ? 'system' : (mode == ThemeMode.light ? 'light' : 'dark');
      await prefs.setString('theme_mode', key);
    } catch (_) {}
  }
}
