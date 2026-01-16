// Widget tests for the Nexus Fertility App

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_fertility_app/main.dart';

void main() {
  testWidgets('App initializes successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(initialTheme: 'system'));
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Theme mode light works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(initialTheme: 'light'));
    final widget = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(widget.themeMode, ThemeMode.light);
  });

  testWidgets('Theme mode dark works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(initialTheme: 'dark'));
    final widget = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(widget.themeMode, ThemeMode.dark);
  });

  testWidgets('Theme mode system works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(initialTheme: 'system'));
    final widget = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(widget.themeMode, ThemeMode.system);
  });

  testWidgets('App has localization support', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(initialTheme: 'system'));
    final widget = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(widget.localizationsDelegates, isNotEmpty);
    expect(widget.supportedLocales, isNotEmpty);
  });
}
