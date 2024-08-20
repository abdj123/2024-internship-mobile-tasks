import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class LogOutUseCase {
  final UserRepository userRepository;

  LogOutUseCase(this.userRepository);

  Future<Either<Failure, bool>> execute() async {
    return await userRepository.userLogOut();
  }
}
