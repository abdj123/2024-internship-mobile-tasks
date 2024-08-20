import 'package:flutter_test/flutter_test.dart';
import 'package:first_application/features/authentication/data/models/user_model.dart';
import 'package:first_application/features/authentication/domain/entities/user.dart';

void main() {
  const testUserModel = UserModel(
    id: '123',
    name: 'Test User',
    email: 'test@example.com',
  );

  const testUserEntity = UserEntity(
    id: '123',
    name: 'Test User',
    email: 'test@example.com',
  );

  final Map<String, dynamic> testJson = {
    'id': '123',
    'name': 'Test User',
    'email': 'test@example.com',
  };

  final Map<String, dynamic> testJsonRegister = {
    'data': {
      'id': '123',
      'name': 'Test User',
      'email': 'test@example.com',
    },
  };

  final Map<String, dynamic> testJsonGetMe = {
    'data': {
      '_id': '123',
      'name': 'Test User',
      'email': 'test@example.com',
    },
  };

  group('UserModel', () {
    test('should be a subclass of UserEntity', () {
      expect(testUserModel, isA<UserEntity>());
    });

    test('fromJson should return a valid model', () {
      final result = UserModel.fromJson(testJson);
      expect(result, testUserModel);
    });

    test('fromJsonRegiset should return a valid model', () {
      final result = UserModel.fromJsonRegiset(testJsonRegister);
      expect(result, testUserModel);
    });

    test('fromJsonGetMe should return a valid model', () {
      final result = UserModel.fromJsonGetMe(testJsonGetMe);
      expect(result, testUserModel);
    });

    test('toEntity should return a UserEntity', () {
      final result = testUserModel.toEntity();
      expect(result, testUserEntity);
    });

    test('toJson should return a JSON map containing proper data', () {
      final result = testUserModel.toJson();
      expect(result, testJson);
    });

    test('fromEntity should return a UserModel', () {
      final result = UserModel.fromEntity(testUserEntity);
      expect(result, testUserModel);
    });
  });
}
