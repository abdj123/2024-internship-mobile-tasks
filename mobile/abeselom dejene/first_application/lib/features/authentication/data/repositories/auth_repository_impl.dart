import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:first_application/core/error/failure.dart';
import 'package:first_application/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:first_application/features/authentication/domain/entities/user.dart';
import 'package:first_application/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/error/exception.dart';
import '../datasources/auth_local_data_source.dart';

class UserRepositoryImpl extends UserRepository {
  late UserRemoteDataSource userRemoteDataSource;
  final AuthLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> userLogIn(
      UserEntity userEntity, String password) async {
    try {
      final result = await userRemoteDataSource.loginUser(userEntity, password);
      await localDataSource.cacheToken(result);
      await localDataSource.cacheLoginStatus(true);

      return const Right("Login Successful");
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> userLogOut() async {
    await localDataSource.clearToken();
    await localDataSource.cacheLoginStatus(false);
    return const Right(true);
  }

  @override
  Future<Either<Failure, UserEntity>> userSignUp(
      UserEntity userEntity, String password) async {
    try {
      final result =
          await userRemoteDataSource.registerUser(userEntity, password);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
