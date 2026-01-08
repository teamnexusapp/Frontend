# LANGUAGE REMOVAL CHECKLIST

## IMMEDIATE ACTIONS REQUIRED:

### 1. CODEBASE CLEANUP
- [ ] Remove all .arb/.json files for non-approved languages
- [ ] Update lib/l10n/ to contain ONLY: app_en.arb, app_yo.arb, app_ig.arb, app_ha.arb
- [ ] Remove any Spanish (es), French (fr), Portuguese (pt) or other language imports
- [ ] Update LocalizationProvider to only support 4 languages

### 2. UI UPDATES
- [ ] Update language selection screen to show ONLY 4 options
- [ ] Remove any flags/icons for non-approved languages
- [ ] Update language switcher UI text/descriptions

### 3. CONFIGURATION
- [ ] Update pubspec.yaml to include ONLY 4 language packages
- [ ] Update supportedLocales in MaterialApp to ONLY 4 languages
- [ ] Remove any language-specific assets for non-approved languages

### 4. TESTING
- [ ] Update all tests to use ONLY approved languages
- [ ] Remove test cases for Spanish/other languages
- [ ] Add compliance tests to ensure no unauthorized languages

### 5. DOCUMENTATION
- [ ] Update README.md with language restrictions
- [ ] Update API documentation
- [ ] Update user documentation/help files

## VERIFICATION:
- [ ] App builds with ONLY 4 languages
- [ ] Language switcher shows exactly 4 options
- [ ] No runtime errors when switching languages
- [ ] All screens display correctly in all 4 languages

## PREVENTION:
- [ ] Add pre-commit hook to check for unauthorized language files
- [ ] Add CI/CD check for language compliance
- [ ] Document this restriction in onboarding for new developers
