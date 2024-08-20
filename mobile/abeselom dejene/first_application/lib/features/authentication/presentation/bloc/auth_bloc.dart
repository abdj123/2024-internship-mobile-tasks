import 'package:equatable/equatable.dart';
import 'package:first_application/features/authentication/domain/entities/user.dart';
import 'package:first_application/features/authentication/domain/usecases/log_in_usecase.dart';
import 'package:first_application/features/authentication/domain/usecases/log_out_usecase.dart';
import 'package:first_application/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LogOutUseCase logOutUseCase;
  AuthBloc(this.loginUseCase, this.signUpUseCase, this.logOutUseCase)
      : super(AuthInitial()) {
    on<LogInEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result =
          await loginUseCase.execute(event.userEntity, event.password);
      result.fold((failure) {
        emit(FailuerState(failure.message));
      }, (data) {
        emit(SuccessState(data));
      });
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result =
          await signUpUseCase.execute(event.userEntity, event.password);
      result.fold((failure) {
        emit(FailuerState(failure.message));
      }, (data) {
        emit(const SuccessState("User Registerd Successfuly"));
      });
    });

    on<LogOutEvent>((event, emit) async {
      emit(AuthLoadingState());
      await logOutUseCase.execute();
      emit(AuthInitial());
    });
  }
}
