class User {
    final String? ttcHistory;
    final String? faithPreference;
    final int? cycleLength;
    final String? lastPeriodDate;
  final String? id;
  final String email;
  final String? username;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final String? profileImageUrl;
  final String? gender;
  final String? preferredLanguage;
  final String? role;
  final bool emailVerified;
  final bool phoneVerified;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.email,
    this.username,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.profileImageUrl,
    this.gender,
    this.preferredLanguage,
    this.role,
    this.emailVerified = false,
    this.phoneVerified = false,
    required this.createdAt,
    this.updatedAt,
    this.ttcHistory,
    this.faithPreference,
    this.cycleLength,
    this.lastPeriodDate,
  });

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? profileImageUrl,
    String? gender,
    String? preferredLanguage,
    String? role,
    bool? emailVerified,
    bool? phoneVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? ttcHistory,
    String? faithPreference,
    int? cycleLength,
    String? lastPeriodDate,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      gender: gender ?? this.gender,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      role: role ?? this.role,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ttcHistory: ttcHistory ?? this.ttcHistory,
      faithPreference: faithPreference ?? this.faithPreference,
      cycleLength: cycleLength ?? this.cycleLength,
      lastPeriodDate: lastPeriodDate ?? this.lastPeriodDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'profileImageUrl': profileImageUrl,
      'gender': gender,
      'preferredLanguage': preferredLanguage,
      'role': role,
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'ttcHistory': ttcHistory,
      'faithPreference': faithPreference,
      'cycleLength': cycleLength,
      'lastPeriodDate': lastPeriodDate,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json;
    if (data['data'] is Map<String, dynamic>) {
      data = Map<String, dynamic>.from(data['data']);
    }
    if (data['user'] is Map<String, dynamic>) {
      // If the payload wraps the user under 'user'
      final inner = Map<String, dynamic>.from(data['user']);
      // Merge outer keys as fallbacks
      data = {...data, ...inner};
    }
    if (data['profile'] is Map<String, dynamic>) {
      // Some APIs split profile fields; merge them as hints
      final profile = Map<String, dynamic>.from(data['profile']);
      data = {...profile, ...data};
    }

    final ttcHistory = data['ttc_history'] ?? data['ttcHistory'];
    final faithPreference = data['faith_preference'] ?? data['faithPreference'];
    final cycleLength = data['cycle_length'] ?? data['cycleLength'];
    final lastPeriodDate = data['last_period_date'] ?? data['lastPeriodDate'];

    // Normalize fields with fallbacks
    String? id = data['id'] ?? data['_id'];
    String? email = data['email'] ?? data['email_address'];
    String? username = data['username'] ?? data['user_name'];
    String? phoneNumber = data['phoneNumber'] ?? data['phone_number'] ?? data['phone'];
    String? firstName = data['firstName'] ?? data['first_name'];
    String? lastName = data['lastName'] ?? data['last_name'];

    // If only a single name is provided, try to split it
    if ((firstName == null || (firstName is String && firstName.trim().isEmpty)) &&
        (lastName == null || (lastName is String && lastName.trim().isEmpty))) {
      final fullName = data['full_name'] ?? data['name'] ?? data['display_name'];
      if (fullName is String && fullName.trim().isNotEmpty) {
        final parts = fullName.trim().split(RegExp(r"\s+"));
        firstName = parts.isNotEmpty ? parts.first : null;
        lastName = parts.length > 1 ? parts.sublist(1).join(' ') : null;
      }
    }

    DateTime? dateOfBirth;
    final dobRaw = data['dateOfBirth'] ?? data['date_of_birth'] ?? data['dob'];
    if (dobRaw is String && dobRaw.isNotEmpty) {
      try { dateOfBirth = DateTime.parse(dobRaw); } catch (_) {}
    }

    final profileImageUrl = data['profileImageUrl'] ?? data['profile_image_url'] ?? data['avatar_url'];
    final gender = data['gender'];
    final preferredLanguage = data['preferredLanguage'] ?? data['language_preference'] ?? data['locale'];
    final role = data['role'];
    final emailVerified = (data['emailVerified'] ?? data['email_verified'] ?? false) == true;
    final phoneVerified = (data['phoneVerified'] ?? data['phone_verified'] ?? false) == true;

    DateTime createdAt = DateTime.now();
    final createdRaw = data['createdAt'] ?? data['created_at'] ?? data['created'];
    if (createdRaw is String && createdRaw.isNotEmpty) {
      try { createdAt = DateTime.parse(createdRaw); } catch (_) {}
    }
    DateTime? updatedAt;
    final updatedRaw = data['updatedAt'] ?? data['updated_at'] ?? data['updated'];
    if (updatedRaw is String && updatedRaw.isNotEmpty) {
      try { updatedAt = DateTime.parse(updatedRaw); } catch (_) {}
    }

    // Ensure email is non-null; if missing, try to derive from username (leave as empty if unknown)
    email = (email is String && email.trim().isNotEmpty)
        ? email
        : (data['contact'] is Map && (data['contact']['email'] is String)
            ? data['contact']['email'] as String
            : '');

    return User(
      id: id,
      email: email,
      username: username,
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      profileImageUrl: profileImageUrl,
      gender: gender,
      preferredLanguage: preferredLanguage,
      role: role,
      emailVerified: emailVerified,
      phoneVerified: phoneVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
      ttcHistory: ttcHistory,
      faithPreference: faithPreference,
      cycleLength: cycleLength is int ? cycleLength : int.tryParse(cycleLength?.toString() ?? ''),
      lastPeriodDate: lastPeriodDate,
    );
  }
}
