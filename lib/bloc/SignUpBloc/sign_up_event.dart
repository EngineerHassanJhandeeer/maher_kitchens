part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpEventApi extends SignUpEvent {
  SignUpApiModel signUpDataEvent;
  SignUpEventApi({required this.signUpDataEvent});
}
