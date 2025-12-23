import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_fertility_app/models/user.dart';

void main() {
  group('User.fromJson robustness', () {
    test('parses snake_case fields', () {
      final json = {
        'id': '123',
        'email': 'john@example.com',
        'first_name': 'John',
        'last_name': 'Doe',
        'created_at': '2024-01-01T00:00:00Z',
      };
      final user = User.fromJson(json);
      expect(user.email, 'john@example.com');
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
    });

    test('parses nested user and profile', () {
      final json = {
        'data': {
          'user': {
            'id': 'u1',
            'email_address': 'ada@example.com',
            'username': 'ada',
            'profile': {
              'first_name': 'Ada',
              'last_name': 'Lovelace'
            }
          }
        }
      };
      final user = User.fromJson(json);
      expect(user.email, 'ada@example.com');
      expect(user.username, 'ada');
      expect(user.firstName, 'Ada');
      expect(user.lastName, 'Lovelace');
    });

    test('splits full_name when first/last missing', () {
      final json = {
        'name': 'Grace Hopper',
        'email': 'grace@example.com',
      };
      final user = User.fromJson(json);
      expect(user.firstName, 'Grace');
      expect(user.lastName, 'Hopper');
    });
  });
}
