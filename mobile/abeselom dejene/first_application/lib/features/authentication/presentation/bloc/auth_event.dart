part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LogInEvent extends AuthEvent {
  UserEntity userEntity;
  String password;
  LogInEvent(
    this.userEntity,
    this.password,
  );
}

class LogOutEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  UserEntity userEntity;
  String password;
  SignUpEvent(
    this.userEntity,
    this.password,
  );
}
