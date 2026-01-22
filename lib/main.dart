import "package:flutter/material.dart";
import "screens/calendar_screen.dart";
import "theme/app_theme.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nexus Fertility",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const CalendarScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
