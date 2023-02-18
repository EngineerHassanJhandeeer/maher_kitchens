part of 'confirm_order_bloc.dart';

@immutable
abstract class ConfirmOrderEvent {}

class ConfirmOrderSuccessfullyEvent extends ConfirmOrderEvent {
  ConfirmOrderModel model;
  ConfirmOrderSuccessfullyEvent({required this.model});
}

// class GetCurrentLocationOfUserSuccessfullyEvent extends ConfirmOrderEvent {}
