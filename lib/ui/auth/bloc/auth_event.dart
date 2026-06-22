part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthButtonIsClicked extends AuthEvent{
  final String username;
  final String password;

 const AuthButtonIsClicked({required this.username, required this.password});
}

class AuthModeChangeISClicked extends AuthEvent{}

class AuthStarted extends AuthEvent{}