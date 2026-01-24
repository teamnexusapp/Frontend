import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryLight = Color(0xFFDFF0E0);
  static const Color background = Colors.white;
  static const Color surface = Colors.white;
  static const Color accent = Color(0xFF6ABF69);
}

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary, brightness: Brightness.light),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, foregroundColor: Colors.black),
  scaffoldBackgroundColor: AppColors.background,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary), foregroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  ),
  inputDecorationTheme: const InputDecorationTheme(filled: true, fillColor: Color(0xFFF6F8F6), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)))),
);



