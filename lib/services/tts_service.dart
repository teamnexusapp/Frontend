import 'package:flutter/foundation.dart';

/// Lightweight, test-friendly TTS service.
///
/// This is a stub implementation that mimics TTS behavior (start/stop)
/// without depending on platform plugins. For production builds you can
/// replace this with a real implementation that uses `flutter_tts`.
class TtsService extends ChangeNotifier {
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  String _language = 'en-US';
  String get language => _language;

  TtsService();

  Future<void> setLanguage(String code) async {
    _language = code;
    notifyListeners();
  }

  Future<void> speak(String text) async {
    if (text.isEmpty) return;
    _isPlaying = true;
    notifyListeners();
    // Simulate speaking delay for short texts.
    await Future.delayed(Duration(milliseconds: 300 + (text.length * 5)));
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> stop() async {
    _isPlaying = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _isPlaying = false;
    super.dispose();
  }
}


