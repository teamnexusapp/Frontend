import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_fertility_app/services/auth_service.dart';
import 'package:nexus_fertility_app/models/user.dart';

void main() {
  group('AuthService Tests', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('getCurrentUser returns null when no user is logged in', () {
      expect(authService.getCurrentUser(), isNull);
    });

    test('currentUser getter returns null initially', () {
      expect(authService.currentUser, isNull);
    });

    test('signOut clears current user', () async {
      await authService.signOut();
      expect(authService.currentUser, isNull);
    });

    test('authStateChanges stream is available', () {
      expect(authService.authStateChanges, isNotNull);
      expect(authService.authStateChanges, isA<Stream<User?>>());
    });
  });

  group('User Model Tests', () {
    test('User creation with required fields', () {
      final user = User(
        email: 'test@example.com',
        createdAt: DateTime.now(),
      );

      expect(user.email, equals('test@example.com'));
      expect(user.emailVerified, isFalse);
      expect(user.phoneVerified, isFalse);
    });

    test('User copyWith creates new instance with updated fields', () {
      final originalUser = User(
        email: 'test@example.com',
        firstName: 'John',
        createdAt: DateTime.now(),
      );

      final updatedUser = originalUser.copyWith(
        firstName: 'Jane',
        lastName: 'Doe',
      );

      expect(updatedUser.firstName, equals('Jane'));
      expect(updatedUser.lastName, equals('Doe'));
      expect(updatedUser.email, equals('test@example.com'));
      expect(updatedUser.email, equals(originalUser.email));
    });

    test('User toJson and fromJson work correctly', () {
      final original = User(
        id: 'user-1',
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        emailVerified: true,
        createdAt: DateTime(2024, 1, 1),
      );

      final json = original.toJson();
      final restored = User.fromJson(json);

      expect(restored.id, equals(original.id));
      expect(restored.email, equals(original.email));
      expect(restored.firstName, equals(original.firstName));
      expect(restored.lastName, equals(original.lastName));
      expect(restored.emailVerified, equals(original.emailVerified));
    });

    test('User with optional fields', () {
      final user = User(
        email: 'test@example.com',
        username: 'testuser',
        phoneNumber: '+1234567890',
        createdAt: DateTime.now(),
      );

      expect(user.username, equals('testuser'));
      expect(user.phoneNumber, equals('+1234567890'));
    });

    test('User copyWith preserves unmodified fields', () {
      final original = User(
        id: 'user-1',
        email: 'original@example.com',
        username: 'original',
        firstName: 'Original',
        createdAt: DateTime(2024, 1, 1),
      );

      final updated = original.copyWith(firstName: 'Updated');

      expect(updated.id, equals(original.id));
      expect(updated.email, equals(original.email));
      expect(updated.username, equals(original.username));
      expect(updated.firstName, equals('Updated'));
      expect(updated.createdAt, equals(original.createdAt));
    });
  });

  group('User Model Edge Cases', () {
    test('User handles null optional fields', () {
      final user = User(
        email: 'test@example.com',
        createdAt: DateTime.now(),
      );

      expect(user.firstName, isNull);
      expect(user.lastName, isNull);
      expect(user.username, isNull);
      expect(user.phoneNumber, isNull);
    });

    test('User fromJson handles missing fields gracefully', () {
      final json = {
        'email': 'test@example.com',
      };

      final user = User.fromJson(json);
      expect(user.email, equals('test@example.com'));
    });

    test('User toJson includes all non-null fields', () {
      final user = User(
        id: 'test-id',
        email: 'test@example.com',
        username: 'testuser',
        firstName: 'Test',
        createdAt: DateTime(2024, 1, 1),
      );

      final json = user.toJson();
      expect(json['id'], equals('test-id'));
      expect(json['email'], equals('test@example.com'));
      expect(json['username'], equals('testuser'));
      expect(json['first_name'], equals('Test'));
    });
  });
}
