import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:first_application/core/error/failure.dart';
import 'package:first_application/features/authentication/domain/entities/user.dart';
import 'package:first_application/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/helpers_test.mocks.dart';

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockLogOutUseCase mockLogOutUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockSignUpUseCase = MockSignUpUseCase();
    mockLogOutUseCase = MockLogOutUseCase();
    authBloc = AuthBloc(mockLoginUseCase, mockSignUpUseCase, mockLogOutUseCase);
  });

  const testUserEntity = UserEntity(
    id: '1',
    name: 'Test User',
    email: 'test@example.com',
  );
  const testPassword = 'password';

  group('LogInEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, SuccessState] when LogInEvent is added and login is successful',
      build: () {
        when(mockLoginUseCase.execute(testUserEntity, testPassword))
            .thenAnswer((_) async => const Right('Login Successful'));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogInEvent(testUserEntity, testPassword)),
      expect: () => [
        AuthLoadingState(),
        const SuccessState('Login Successful'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, FailureState] when LogInEvent is added and login fails',
      build: () {
        when(mockLoginUseCase.execute(testUserEntity, testPassword))
            .thenAnswer((_) async => const Left(ServerFailure('Login Failed')));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogInEvent(testUserEntity, testPassword)),
      expect: () => [
        AuthLoadingState(),
        const FailuerState('Login Failed'),
      ],
    );
  });

  group('SignUpEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, SuccessState] when SignUpEvent is added and sign up is successful',
      build: () {
        when(mockSignUpUseCase.execute(testUserEntity, testPassword))
            .thenAnswer((_) async => const Right(testUserEntity));
        return authBloc;
      },
      act: (bloc) => bloc.add(SignUpEvent(testUserEntity, testPassword)),
      expect: () => [
        AuthLoadingState(),
        const SuccessState('User Registered Successfully'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, FailureState] when SignUpEvent is added and sign up fails',
      build: () {
        when(mockSignUpUseCase.execute(testUserEntity, testPassword))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Sign Up Failed')));
        return authBloc;
      },
      act: (bloc) => bloc.add(SignUpEvent(testUserEntity, testPassword)),
      expect: () => [
        AuthLoadingState(),
        const FailuerState('Sign Up Failed'),
      ],
    );
  });

  group('LogOutEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, AuthInitial] when LogOutEvent is added',
      build: () {
        when(mockLogOutUseCase.execute())
            .thenAnswer((_) async => const Right(true));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogOutEvent()),
      expect: () => [
        AuthLoadingState(),
        AuthInitial(),
      ],
    );
  });
}
