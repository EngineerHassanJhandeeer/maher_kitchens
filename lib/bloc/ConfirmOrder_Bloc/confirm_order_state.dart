part of 'confirm_order_bloc.dart';

@immutable
abstract class ConfirmOrderState {}

class ConfirmOrderInitialState extends ConfirmOrderState {}

class ConfirmOrderSuccessfullyState extends ConfirmOrderState {
  final String message;
  ConfirmOrderSuccessfullyState({required this.message});
}

class ConfirmOrderFailedState extends ConfirmOrderState {
  final String message;
  ConfirmOrderFailedState({required this.message});
}

// class GetCurrentLocationOfUserSuccessfullyState extends ConfirmOrderState {
//   final String address;
//   GetCurrentLocationOfUserSuccessfullyState({required this.address});
// }
