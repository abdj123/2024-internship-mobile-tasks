import 'package:dartz/dartz.dart';
import 'package:first_application/features/authentication/domain/entities/user.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final UserRepository userRepository;

  LoginUseCase(this.userRepository);

  Future<Either<Failure, String>> execute(
      UserEntity userEntity, String password) async {
    return await userRepository.userLogIn(userEntity, password);
  }
}
