part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginEventApi extends LoginEvent {
  String email;
  String password;
  LoginEventApi({required this.email, required this.password});
}

class GoogleLogInEventApi extends LoginEvent {
  final LogInWithGoogleModel logInWithGoogleModel;
  GoogleLogInEventApi({required this.logInWithGoogleModel});
}
