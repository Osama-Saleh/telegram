part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class ShowPasswordState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String? token;

  LoginSuccessState(this.token);
}

class LoginErrorState extends LoginState {}

