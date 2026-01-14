import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void testLocalization() {
  print("Supported locales:");
  for (var locale in AppLocalizations.supportedLocales) {
    print("- ${locale.languageCode}");
  }
}
