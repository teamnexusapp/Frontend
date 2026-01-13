import 'package:flutter/material.dart';

class AppColors {
<<<<<<< HEAD
  // Brand greens (tweak to match your assets)
  static const Color primary = Color(0xFF0A8F3A);
  static const Color primaryVariant = Color(0xFF064B2A);
  static const Color success = Color(0xFF2ECC71);
  static const Color onPrimary = Colors.white;

  // neutrals
  static const Color surfaceLight = Colors.white;
  static const Color backgroundLight = Color(0xFFF6F7F9);
  static const Color surfaceDark = Color(0xFF0B1220);
  static const Color backgroundDark = Color(0xFF071018);
}

ThemeData lightTheme() {
  final colorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    surface: AppColors.surfaceLight,
    background: AppColors.backgroundLight,
    secondary: AppColors.primaryVariant,
  );

  return ThemeData(
    colorScheme: colorScheme,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: colorScheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
    ),
    useMaterial3: false,
  );
}

ThemeData darkTheme() {
  final colorScheme = ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    surface: AppColors.surfaceDark,
    background: AppColors.backgroundDark,
    secondary: AppColors.primaryVariant,
  );

  return ThemeData(
    colorScheme: colorScheme,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: colorScheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
    ),
    useMaterial3: false,
  );
}
=======
  static const Color primary = Color(0xFF2E7D32); // deep green
  static const Color primaryLight = Color(0xFFDFF0E0);
  static const Color background = Colors.white;
  static const Color surface = Colors.white;
  static const Color accent = Color(0xFF6ABF69);
}

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: Colors.black,
  ),
  scaffoldBackgroundColor: AppColors.background,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: AppColors.primary),
      foregroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFF6F8F6),
    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
  ),
);
>>>>>>> origin/main
