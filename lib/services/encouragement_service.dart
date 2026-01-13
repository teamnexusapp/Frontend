import 'dart:math';

enum FaithMode { neutral, christian, muslim }

class EncouragementService {
  final _random = Random();

  static const List<String> _neutralMessages = [
    'Your journey is unique and valid. Every step forward is a victory.',
    'Small steps matter — celebrate progress each day.',
    'Breathe. You are resilient and loved.',
  ];

  static const List<String> _christianQuotes = [
    '"Be still, and know that I am God." — Psalm 46:10',
    '"Cast all your anxiety on him because he cares for you." — 1 Peter 5:7',
    'Pray, trust, and continue — God is beside you.',
  ];

  static const List<String> _muslimQuotes = [
    '"Indeed, with hardship will be ease." — Quran 94:6',
    'Turn to prayer and patience in times of difficulty.',
    'Place your trust in Allah and take gentle steps forward.',
  ];

  String dailyMessage(FaithMode mode) {
    switch (mode) {
      case FaithMode.christian:
        return _christianQuotes[_random.nextInt(_christianQuotes.length)];
      case FaithMode.muslim:
        return _muslimQuotes[_random.nextInt(_muslimQuotes.length)];
      case FaithMode.neutral:
      default:
        return _neutralMessages[_random.nextInt(_neutralMessages.length)];
    }
  }

  List<String> faithQuotes(FaithMode mode) {
    switch (mode) {
      case FaithMode.christian:
        return _christianQuotes;
      case FaithMode.muslim:
        return _muslimQuotes;
      case FaithMode.neutral:
      default:
        return _neutralMessages;
    }
  }
}
