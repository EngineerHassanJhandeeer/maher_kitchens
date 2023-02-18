part of 'user_location_bloc.dart';

@immutable
abstract class UserLocationState {}

class UserLocationInitialState extends UserLocationState {}

class GetCurrentLocationOfUserSuccessfullyState extends UserLocationState {
  final String address;
  GetCurrentLocationOfUserSuccessfullyState({required this.address});
}

class GetCurrentLocationOfUserfaildedState extends UserLocationState {
  final String message;
  GetCurrentLocationOfUserfaildedState({required this.message});
}
