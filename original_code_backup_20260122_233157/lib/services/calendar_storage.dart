import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CalendarStorage {
  // SharedPreferences keys
  static const _kTappedDays = 'tapped_days';
  static const _kNextPeriod = 'next_period_date';
  static const _kPeriodHistory = 'period_history';
  static const _kCycleLength = 'cycle_length';
  static const _kOvulationPredictions = 'ovulation_predictions';

  // ---------- SharedPreferences helpers ----------
  static Future<void> saveNextPeriodDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kNextPeriod, DateFormat('yyyy-MM-dd').format(date));
  }

  static Future<DateTime?> loadNextPeriodDate() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_kNextPeriod);
    return s == null ? null : DateTime.parse(s);
  }

  static Future<void> savePeriodHistory(List<DateTime> history) async {
    final prefs = await SharedPreferences.getInstance();
    final strings = history.map((d) => DateFormat('yyyy-MM-dd').format(d)).toList();
    await prefs.setStringList(_kPeriodHistory, strings);
  }

  static Future<List<DateTime>> loadPeriodHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kPeriodHistory) ?? <String>[];
    return list.map((s) => DateTime.parse(s)).toList();
  }

  static Future<void> saveCycleLength(int days) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kCycleLength, days);
  }

  static Future<int> loadCycleLength({int defaultValue = 28}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kCycleLength) ?? defaultValue;
  }

  static Future<void> saveOvulationPredictions(List<DateTime> days) async {
    final prefs = await SharedPreferences.getInstance();
    final strings = days.map((d) => DateFormat('yyyy-MM-dd').format(d)).toList();
    await prefs.setStringList(_kOvulationPredictions, strings);
  }

  static Future<List<DateTime>> loadOvulationPredictions() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kOvulationPredictions) ?? <String>[];
    return list.map((s) => DateTime.parse(s)).toList();
  }

  /// Compute ovulation and fertile window predictions from a last period start
  /// and cycle length.
  ///
  /// Simple heuristic: ovulationDay = lastPeriodStart + (cycleLength - 14) days
  /// Fertile window = ovulationDay - 5 .. ovulationDay + 1 (inclusive)
  static List<DateTime> computeOvulationPredictions({
    required DateTime lastPeriodStart,
    required int cycleLength,
    int fertileWindowDaysBefore = 5,
    int fertileWindowDaysAfter = 1,
  }) {
    final ovulationOffset = cycleLength - 14;
    final ovulationDay = DateTime(;
      lastPeriodStart.year,
      lastPeriodStart.month,
      lastPeriodStart.day,
    ).add(Duration(days: ovulationOffset));

    final List<DateTime> days = [];
    for (int i = -fertileWindowDaysBefore; i <= fertileWindowDaysAfter; i++) {
      final d = DateTime(ovulationDay.year, ovulationDay.month, ovulationDay.day).add(Duration(days: i));
      days.add(d);
    }
    return days;
  }

  /// Convenience: compute predictions and persist them to SharedPreferences.
  static Future<void> computeAndSavePredictions({
    required DateTime lastPeriodStart,
    required int cycleLength,
  }) async {
    final preds = computeOvulationPredictions(lastPeriodStart: lastPeriodStart, cycleLength: cycleLength);
    await saveOvulationPredictions(preds);
  }

  static Future<void> saveTappedDays(Set<DateTime> days) async {
    final prefs = await SharedPreferences.getInstance();
    final strings = days.map((d) => DateFormat('yyyy-MM-dd').format(d)).toList();
    await prefs.setStringList(_kTappedDays, strings);
  }

  static Future<Set<DateTime>> loadTappedDays() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kTappedDays) ?? <String>[];
    return list.map((s) => DateTime.parse(s)).toSet();
  }

  // ---------- SQLite helpers & migration ----------
  static Database? _db;

  static Future<Database> _openDb() async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'nexus_calendar.db');
    _db = await openDatabase(;
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE period_days (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            day TEXT NOT NULL UNIQUE
          )
        ''');
        await db.execute('''
          CREATE TABLE ovulation_predictions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            day TEXT NOT NULL UNIQUE
          )
        ''');
      },
    );
    return _db!;
  }

  /// Migrate existing SharedPreferences tapped days into SQLite `period_days` table.
  /// This is safe to call multiple times; duplicates are ignored by UNIQUE constraint.
  static Future<void> migrateFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final tapped = prefs.getStringList(_kTappedDays) ?? <String>[];
    if (tapped.isEmpty) return;
    final db = await _openDb();
    final batch = db.batch();
    for (final s in tapped) {
      batch.insert('period_days', {'day': s}, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    await batch.commit(noResult: true);
    // Optionally clear SharedPreferences key after migration (commented out)
    // await prefs.remove(_kTappedDays);
  }

  static Future<List<DateTime>> loadPeriodDaysFromDb() async {
    final db = await _openDb();
    final rows = await db.query('period_days', columns: ['day']);
    return rows.map((r) => DateTime.parse(r['day'] as String)).toList();
  }

  static Future<void> addPeriodDayToDb(DateTime day) async {
    final db = await _openDb();
    final s = DateFormat('yyyy-MM-dd').format(day);
    await db.insert('period_days', {'day': s}, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<void> removePeriodDayFromDb(DateTime day) async {
    final db = await _openDb();
    final s = DateFormat('yyyy-MM-dd').format(day);
    await db.delete('period_days', where: 'day = ?', whereArgs: [s]);
  }
}




