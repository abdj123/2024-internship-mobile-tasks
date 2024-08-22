import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:first_application/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:first_application/core/error/exception.dart';
import 'package:first_application/core/error/failure.dart';
import 'package:first_application/features/authentication/data/models/user_model.dart';
import 'package:first_application/features/authentication/domain/entities/user.dart';

import '../../../../helpers/helpers_test.mocks.dart';
import '../../../../helpers/json_reader.dart';

void main() {
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late UserRepositoryImpl userRepositoryImpl;
  late MockAuthLocalDataSource mockAuthLocalDataSource;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    userRepositoryImpl = UserRepositoryImpl(
      userRemoteDataSource: mockUserRemoteDataSource,
      localDataSource: mockAuthLocalDataSource,
    );
  });

  final data = readJson('helpers/dummy_data/auth_dummy_data.json');

  final jsonDecode = json.decode(data);
  final UserModel userModel = UserModel.fromJson(jsonDecode);
  final UserEntity userEntity = userModel.toEntity();

  group('UserRepositoryImpl', () {
    test('should return LoginEntity when login is successful', () async {
      // arrange
      when(mockUserRemoteDataSource.loginUser(userEntity, 'test_password'))
          .thenAnswer((_) async => 'test_token');
      when(mockAuthLocalDataSource.cacheToken('test_token'))
          .thenAnswer((_) async {});
      when(mockAuthLocalDataSource.cacheLoginStatus(true))
          .thenAnswer((_) async {});

      // act
      final result =
          await userRepositoryImpl.userLogIn(userEntity, 'test_password');

      // assert
      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r), equals('Login Successful'));
    });

    test('should return ServerFailure when login fails', () async {
      // arrange
      when(mockUserRemoteDataSource.loginUser(userEntity, 'test_password'))
          .thenThrow(ServerException());

      // act
      final result =
          await userRepositoryImpl.userLogIn(userEntity, 'test_password');

      // assert
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    });

    test('should return ConnectionFailure when there is no network', () async {
      // arrange
      when(mockUserRemoteDataSource.loginUser(userEntity, 'test_password'))
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result =
          await userRepositoryImpl.userLogIn(userEntity, 'test_password');

      // assert
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ConnectionFailure>());
    });
  });
}
