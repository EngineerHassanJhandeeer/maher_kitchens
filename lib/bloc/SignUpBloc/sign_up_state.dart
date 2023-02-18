part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}



class SignUpSuccessfullyState extends SignUpState {
  final apiData;
  SignUpSuccessfullyState({required this.apiData});
}

class SignUpErrorState extends SignUpState {
  String errorMessage;
  SignUpErrorState({required this.errorMessage});
}
