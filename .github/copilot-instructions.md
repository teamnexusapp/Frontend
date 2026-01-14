## Purpose
Provide concise, actionable guidance for an AI coding agent working on this Flutter repo.

## Big Picture
- Flutter mobile app (lib/) using Provider for state management and optional Firebase Auth.
- UI localization via generated ARB files in `lib/l10n/` (four supported locales: `en`, `ha`, `ig`, `yo`).
- Local persistence for small user state uses `SharedPreferences` (see calendar persistence below).
- The calendar UI is a custom, swipeable component in `lib/widgets/swipeable_green_calendar.dart` used from `lib/screens/calendar_tab_screen.dart`.

## Key files to read first
- `lib/main.dart` — app entry, `supportedLocales`, provider setup and routes.
- `lib/screens/calendar_tab_screen.dart` — calendar state, persistence, and UX for period tracking.
- `lib/widgets/swipeable_green_calendar.dart` — month grid and day rendering (where to add custom markers).
- `lib/services/` — backend and auth helpers (e.g. `api_service.dart`, `auth_service.dart`).
- `lib/l10n/` — ARB localization files and generated `flutter_gen/gen_l10n` usage.
- `README.md`, `QUICK_START.md`, `IMPLEMENTATION_SUMMARY.md` — developer workflows and repository policies.

## Persistence patterns (important)
- Calendar selected days are saved to `SharedPreferences` under key `tapped_days` as a `List<String>` of yyyy-MM-dd (see `calendar_tab_screen.dart::_loadTappedDays` and `_toggleCalendarDate`).
- Theme is stored under `theme_mode` as a string (see `main.dart`).
- When changing persisted keys, update all read/write sites and consider migration for existing users.

Example: The app expects `tapped_days` values like `2025-12-31`. Any migration must convert old formats to this ISO date string.

## Calendar customization (where to change visuals/markers)
- `SwipeableGreenCalendar` builds every day in `_MonthGrid.itemBuilder` and draws selected days with `_accent` color.
- To add ovulation or period markers, add a predicate and adjust the `Container.decoration` and text color. Example insertion near where `isSelected` is computed:

```dart
final isOvulation = myOvulationDates.any((d) => _isSameDay(d, dayInfo.date));
final isPeriodDay = myPeriodDates.any((d) => _isSameDay(d, dayInfo.date));
Color bgColor = Colors.transparent;
if (isPeriodDay) bgColor = Colors.red.withOpacity(0.95);
else if (isOvulation) bgColor = const Color(0xFFA8D497); // green
// then use bgColor in BoxDecoration
```

Also: the widget expects `selectedDates` as `Set<DateTime>` normalized to year/month/day. Update the parent (`calendar_tab_screen.dart`) to compute ovulation/cycle predictions and pass them either via `selectedDates` or a new prop.

## Localization / Long articles
- UI strings use ARB files in `lib/l10n/` and generated `AppLocalizations` (see `main.dart` and `pubspec.yaml` `flutter: generate: true`).
- The repo enforces exactly four locale ARB files (README describes a GitHub Action `/.github/workflows/l10n-check.yml` that rejects extra locales).
- For long, multi-paragraph educational articles: this repo does not currently store article content in ARB files. Recommended, discoverable approach:
  - Add per-language JSON assets under `assets/articles/{en,ha,ig,yo}/...` and load them via `rootBundle.loadString` or a small `ArticleRepository` under `lib/services/`.
  - Alternatively, use a remote CMS/Firestore if backend exists; note: Firestore dependency is not present in `pubspec.yaml` so prefer local assets unless backend is added.

## Build, test, and common commands
- Get dependencies and run: `flutter pub get` then `flutter run`.
- Generate localization if you change ARB: `flutter gen-l10n` (the project already uses generated localizations).
- Run tests: `flutter test` and specific tests like `flutter test test/auth_service_test.dart` (documented in README).

## Conventions & patterns
- Dates persisted as ISO `yyyy-MM-dd` strings (SharedPreferences lists). Keep serialization consistent.
- UI components often normalize DateTime to midnight (year/month/day) before comparing—use the `_isSameDay` helpers.
- State flows: lightweight local state + `SharedPreferences` for small items; Provider-backed ChangeNotifiers for app-scoped state (see `AuthService`, `LocalizationProvider`).

## Integration points & external systems
- Firebase Auth: present and optionally initialized in `main.dart` (guarded by `FeatureFlags.firebaseAuthAvailable`).
- API calls are in `lib/services/api_service.dart` (used to fetch symptoms and other backend data).

## Small recipes (copy-paste ready)
- Save tapped days (already implemented):
  - Key: `tapped_days`
  - Value: `List<String>` of ISO dates
- Read on login/start: call `SharedPreferences.getInstance()` and read `tapped_days`, then parse with `DateTime.parse`.

### SharedPreferences examples (save / load common period data)
Use ISO `yyyy-MM-dd` strings for dates. Keep keys consistent across reads/writes.

```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

// Save next period date
Future<void> saveNextPeriodDate(DateTime date) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('next_period_date', DateFormat('yyyy-MM-dd').format(date));
}

// Load next period date
Future<DateTime?> loadNextPeriodDate() async {
  final prefs = await SharedPreferences.getInstance();
  final s = prefs.getString('next_period_date');
  return s == null ? null : DateTime.parse(s);
}

// Save period history (list of past period start dates)
Future<void> savePeriodHistory(List<DateTime> history) async {
  final prefs = await SharedPreferences.getInstance();
  final strings = history.map((d) => DateFormat('yyyy-MM-dd').format(d)).toList();
  await prefs.setStringList('period_history', strings);
}

Future<List<DateTime>> loadPeriodHistory() async {
  final prefs = await SharedPreferences.getInstance();
  final list = prefs.getStringList('period_history') ?? <String>[];
  return list.map((s) => DateTime.parse(s)).toList();
}

// Save numeric values
Future<void> saveCycleLength(int days) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('cycle_length', days);
}

Future<int> loadCycleLength({int defaultValue = 28}) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('cycle_length') ?? defaultValue;
}

// Save predicted ovulation days
Future<void> saveOvulationPredictions(List<DateTime> days) async {
  final prefs = await SharedPreferences.getInstance();
  final strings = days.map((d) => DateFormat('yyyy-MM-dd').format(d)).toList();
  await prefs.setStringList('ovulation_predictions', strings);
}

Future<List<DateTime>> loadOvulationPredictions() async {
  final prefs = await SharedPreferences.getInstance();
  final list = prefs.getStringList('ovulation_predictions') ?? <String>[];
  return list.map((s) => DateTime.parse(s)).toList();
}
```

Example: call `loadNextPeriodDate()` in `calendar_tab_screen.dart` `initState` (or `_loadTappedDays`) and set `_lastPeriodDate` from the returned `DateTime` so it's visible after relogin.

## If you change storage
- When switching to SQLite or secure storage, add a migration path: read existing `tapped_days` and write to new store on first run after update.

---
If any of the areas above are unclear or you want me to include exact code snippets for:
- migrating `tapped_days` to SQLite,
- a full ovulation/highlight implementation in `SwipeableGreenCalendar`, or
- an articles JSON loader and UI — tell me which and I will update this file.
