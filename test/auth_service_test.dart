import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_fertility_app/models/user.dart';
import 'package:nexus_fertility_app/services/auth_service.dart';

void main() {
  group('AuthService Tests', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('Sign up with email should create user', () async {
      final user = await authService.signUpWithEmail(
        email: 'test@example.com',
        password: 'Password123',
        username: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        phoneNumber: '+1234567890',
      );

      expect(user, isNotNull);
      expect(user?.email, equals('test@example.com'));
      expect(user?.emailVerified, isFalse);
    });

    test('Invalid email should throw exception', () async {
      expect(
        () => authService.signUpWithEmail(
          email: 'invalid-email',
          password: 'Password123',
          username: 'testuser',
          firstName: 'Test',
          lastName: 'User',
          phoneNumber: '+1234567890',
        ),
        throwsException,
      );
    });

    test('Short password should throw exception', () async {
      expect(
        () => authService.signUpWithEmail(
          email: 'test@example.com',
          password: 'short',
          username: 'testuser',
          firstName: 'Test',
          lastName: 'User',
          phoneNumber: '+1234567890',
        ),
        throwsException,
      );
    });

    test('OTP verification should update user', () async {
      final user = await authService.signUpWithEmail(
        email: 'test@example.com',
        password: 'Password123',
        username: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        phoneNumber: '+1234567890',
      );

      // Mock OTP verification
      final result = await authService.verifyEmailOTP(
        email: 'test@example.com',
        otp: '123456',
      );

      expect(result, isTrue);
    });

    test('Phone signup should create user with phone', () async {
      final user = await authService.signUpWithPhone(
        phoneNumber: '+1234567890',
        email: 'test2@example.com',
        username: 'testuser2',
        firstName: 'Test2',
        lastName: 'User2',
        password: 'Password123',
      );

      expect(user, isNotNull);
      expect(user?.phoneNumber, equals('+1234567890'));
      expect(user?.phoneVerified, isFalse);
    });

    test('Update profile should update user data', () async {
      final user = await authService.signUpWithEmail(
        email: 'test@example.com',
        password: 'Password123',
      );

      await authService.verifyEmailOTP(
        email: 'test@example.com',
        otp: '123456',
      );

      final updatedUser = await authService.updateUserProfile(
        userId: user?.id ?? 'test-id',
        firstName: 'John',
        lastName: 'Doe',
        dateOfBirth: DateTime(1990, 5, 15),
        gender: 'Male',
      );

      expect(updatedUser, isNotNull);
      expect(updatedUser?.firstName, equals('John'));
      expect(updatedUser?.lastName, equals('Doe'));
      expect(updatedUser?.gender, equals('Male'));
    });

    test('Sign out should clear user', () async {
      await authService.signUpWithEmail(
        email: 'test@example.com',
        password: 'Password123',
      );

      await authService.signOut();
      final currentUser = await authService.getCurrentUser();

      expect(currentUser, isNull);
    });

    test('Get current user should return signed in user', () async {
      final signedUpUser = await authService.signUpWithEmail(
        email: 'test@example.com',
        password: 'Password123',
      );

      await authService.verifyEmailOTP(
        email: 'test@example.com',
        otp: '123456',
      );

      final currentUser = await authService.getCurrentUser();
      expect(currentUser?.email, equals('test@example.com'));
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

    test('User copyWith should create new instance', () {
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
    });

    test('User toJson and fromJson should work correctly', () {
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
  });

  group('Email Validation Tests', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('Valid emails should be accepted', () async {
      final validEmails = [
        'user@example.com',
        'john.doe@example.co.uk',
        'user+tag@example.com',
      ];

      for (final email in validEmails) {
        expect(
          () => authService.signUpWithEmail(
            email: email,
            password: 'Password123',
          ),
          isNotNull,
        );
      }
    });

    test('Invalid emails should be rejected', () async {
      final invalidEmails = [
        'notanemail',
        '@example.com',
        'user@',
        'user name@example.com',
      ];

      for (final email in invalidEmails) {
        expect(
          () => authService.signUpWithEmail(
            email: email,
            password: 'Password123',
          ),
          throwsException,
        );
      }
    });
  });

  group('Phone Validation Tests', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('Valid phone numbers should be accepted', () async {
      final validPhones = [
        '+1 (555) 000-0000',
        '+44 20 7946 0958',
        '+33 1 42 68 53 00',
      ];

      for (final phone in validPhones) {
        final user = await authService.signUpWithPhone(
          phoneNumber: phone,
        );
        expect(user, isNotNull);
      }
    });
  });
}
