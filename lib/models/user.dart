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
    return AppUser(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      username: json['username']?.toString(),
      phoneNumber: json['phoneNumber']?.toString(),
      ttcHistory: json['ttcHistory'] != null 
          ? List<String>.from(json['ttcHistory']) 
          : null,
      faithPreference: json['faithPreference']?.toString(),
      cycleLength: json['cycleLength'] is int 
          ? json['cycleLength'] 
          : (json['cycleLength'] is String ? int.tryParse(json['cycleLength']) : null),
      lastPeriodDate: json['lastPeriodDate'] != null 
          ? DateTime.tryParse(json['lastPeriodDate'].toString()) 
          : null,
      firstName: json['firstName']?.toString(),
      lastName: json['lastName']?.toString(),
      displayName: json['displayName']?.toString(),
      photoUrl: json['photoUrl']?.toString(),
      preferredLanguage: json['preferredLanguage']?.toString(),
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
