part of 'user_location_bloc.dart';

@immutable
abstract class UserLocationEvent {}

class GetCurrentLocationOfUserSuccessfullyEvent extends UserLocationEvent {}
