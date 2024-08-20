part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class SuccessState extends AuthState {
  final String message;

  const SuccessState(this.message);
}

final class AuthLoadingState extends AuthState {}

final class FailuerState extends AuthState {
  final String message;
  const FailuerState(this.message);
}
