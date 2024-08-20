import 'dart:convert';
import 'package:first_application/core/constants/constants.dart';
import 'package:first_application/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:first_application/features/authentication/domain/entities/user.dart';
import 'package:first_application/features/authentication/data/models/user_model.dart';
import 'package:first_application/core/error/exception.dart';

import '../../../../helpers/helpers_test.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;

  late UserRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();

    dataSource = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  const userEntity =
      UserEntity(id: '1', email: 'test@example.com', name: 'Test User');
  const password = 'password';
  final tokenData = {
    'data': {'access_token': 'test_token'}
  };
  const userModel =
      UserModel(id: '1', email: 'test@example.com', name: 'Test User');

  group('loginUser', () {
    test('should return token when login is successful', () async {
      // arrange
      when(mockHttpClient.post(Uri.parse(Urls.loginUrl),
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(json.encode(tokenData), 201));

      // act
      final result = await dataSource.loginUser(userEntity, password);

      // assert
      expect(result, equals('test_token'));
    });

    test('should throw ServerException when login is unsuccessful', () async {
      // arrange
      when(mockHttpClient.post(Uri.parse(Urls.loginUrl),
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      // act
      final call = dataSource.loginUser;

      // assert
      expect(() => call(userEntity, password), throwsA(isA<ServerException>()));
    });
  });

  group('registerUser', () {
    test('should return UserModel when registration is successful', () async {
      // arrange
      when(mockHttpClient.post(Uri.parse(Urls.registerUrl),
              body: anyNamed('body')))
          .thenAnswer(
              (_) async => http.Response(json.encode(userModel.toJson()), 201));

      // act
      final result = await dataSource.registerUser(userEntity, password);

      // assert
      expect(result, equals(userModel));
    });

    test('should throw ServerException when registration is unsuccessful',
        () async {
      // arrange
      when(mockHttpClient.post(Uri.parse(Urls.registerUrl),
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      // act
      final call = dataSource.registerUser;

      // assert
      expect(() => call(userEntity, password), throwsA(isA<ServerException>()));
    });
  });
}
