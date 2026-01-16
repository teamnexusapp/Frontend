// Widget tests for the Nexus Fertility App

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_fertility_app/main.dart';
import 'package:nexus_fertility_app/screens/home_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App loads and shows HomeScreen', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp(initialTheme: 'system'));
    
    // Wait for async operations to complete
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verify that HomeScreen is present (check for bottom navigation or key widgets)
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('App initializes with correct theme', (WidgetTester tester) async {
    // Build app with light theme
    await tester.pumpWidget(const MyApp(initialTheme: 'light'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Get the MaterialApp widget
    final MaterialApp materialApp = tester.widget(find.byType(MaterialApp).first);
    
    // Verify theme mode is set correctly
    expect(materialApp.themeMode, equals(ThemeMode.light));
  });

  testWidgets('App initializes with dark theme', (WidgetTester tester) async {
    // Build app with dark theme
    await tester.pumpWidget(const MyApp(initialTheme: 'dark'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Get the MaterialApp widget
    final MaterialApp materialApp = tester.widget(find.byType(MaterialApp).first);
    
    // Verify theme mode is set correctly
    expect(materialApp.themeMode, equals(ThemeMode.dark));
  });

  testWidgets('HomeScreen has bottom navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(initialTheme: 'system'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Check if bottom navigation bar exists
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
