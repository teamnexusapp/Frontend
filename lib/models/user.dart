import 'dart:convert';

// Alias for backward compatibility
typedef User = AppUser;

class AppUser {
  final String id;
  final String email;
  final String? username;
  final String? phoneNumber;
  final List<String> ttcHistory;
  final String? faithPreference;
  final int? cycleLength;
  final DateTime? lastPeriodDate;
  final String? firstName;
  final String? lastName;
  final String? displayName;
  final String? photoUrl;
  final String? preferredLanguage;
  
  AppUser({
    required this.id,
    required this.email,
    this.username,
    this.phoneNumber,
    List<String>? ttcHistory,
    this.faithPreference,
    this.cycleLength,
    this.lastPeriodDate,
    this.firstName,
    this.lastName,
    this.displayName,
    this.photoUrl,
    this.preferredLanguage,
  }) : ttcHistory = ttcHistory ?? [];
  
  factory AppUser.fromJson(Map<String, dynamic> json) {
    String? _string(dynamic v) => v?.toString();
    int? _int(dynamic v) => v is int
        ? v
        : (v is String ? int.tryParse(v) : null);
    DateTime? _date(dynamic v) => v != null ? DateTime.tryParse(v.toString()) : null;

    // Normalize keys from snake_case or camelCase
    final id = _string(json['id'] ?? json['user_id']) ?? '';
    final firstName = _string(json['firstName'] ?? json['first_name']);
    final lastName = _string(json['lastName'] ?? json['last_name']);
    final phone = _string(json['phoneNumber'] ?? json['phone_number']);
    final faith = _string(json['faithPreference'] ?? json['faith_preference']);
    final lang = _string(json['preferredLanguage'] ?? json['language_preference']);
    final cycle = _int(json['cycleLength'] ?? json['cycle_length']);
    final period = _int(json['periodLength'] ?? json['period_length']); // kept for compatibility
    final lastPeriod = _date(json['lastPeriodDate'] ?? json['last_period_date']);

    List<String>? ttc;
    if (json['ttcHistory'] != null) {
      ttc = List<String>.from(json['ttcHistory']);
    } else if (json['ttc_history'] != null) {
      final dynamic v = json['ttc_history'];
      if (v is List) {
        ttc = v.map((e) => e.toString()).toList();
      } else {
        ttc = [v.toString()];
      }
    }

    return AppUser(
      id: id,
      email: _string(json['email']) ?? '',
      username: _string(json['username']),
      phoneNumber: phone,
      ttcHistory: ttc,
      faithPreference: faith,
      cycleLength: cycle ?? period,
      lastPeriodDate: lastPeriod,
      firstName: firstName,
      lastName: lastName,
      displayName: _string(json['displayName']),
      photoUrl: _string(json['photoUrl']),
      preferredLanguage: lang,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'ttcHistory': ttcHistory,
      'faithPreference': faithPreference,
      'cycleLength': cycleLength,
      'lastPeriodDate': lastPeriodDate?.toIso8601String(),
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'preferredLanguage': preferredLanguage,
    };
  }
  
  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, name: $displayName)';
  }
}
