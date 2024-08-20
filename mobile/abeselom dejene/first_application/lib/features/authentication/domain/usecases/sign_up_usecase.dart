import 'package:dartz/dartz.dart';
import 'package:first_application/features/authentication/domain/entities/user.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final UserRepository userRepository;

  SignUpUseCase(this.userRepository);

  Future<Either<Failure, UserEntity>> execute(
      UserEntity userEntity, String password) async {
    return await userRepository.userSignUp(userEntity, password);
  }
}
