class FeatureFlags {
  // Compile-time flags controlled via --dart-define
  static const bool enableFastApi = bool.fromEnvironment(
    'ENABLE_FASTAPI',
    defaultValue: true,
  );

  // Add more flags as needed, e.g., TTS or analytics
  static const bool enableTts = bool.fromEnvironment(
    'ENABLE_TTS',
    defaultValue: true,
  );
}
