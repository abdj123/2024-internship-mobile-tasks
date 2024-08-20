import 'package:dartz/dartz.dart';
import 'package:first_application/core/error/failure.dart';
import 'package:first_application/features/authentication/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> userLogIn(
      UserEntity userEntity, String password);
  Future<Either<Failure, UserEntity>> userSignUp(
      UserEntity userEntity, String password);
  Future<Either<Failure, bool>> userLogOut();
}
