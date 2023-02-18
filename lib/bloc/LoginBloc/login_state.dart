part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LogInSuccessfullyState extends LoginState {
  String email;
  LogInSuccessfullyState({required this.email});
}

class LoginErrorState extends LoginState {
  final String errorOfLogInMessage;
  LoginErrorState({required this.errorOfLogInMessage});
}
