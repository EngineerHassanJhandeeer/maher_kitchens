part of 'detail_screen_add_to_cart_bloc.dart';

@immutable
abstract class DetailScreenAddToCartState {}

class DetailScreenAddToCartInitialState extends DetailScreenAddToCartState {}

class DetailScreenAddToCartSuccessfullyState
    extends DetailScreenAddToCartState {
  final String message;
  DetailScreenAddToCartSuccessfullyState({required this.message});
}

class DetailScreenAddToCartFailedState extends DetailScreenAddToCartState {
  final String message;
  DetailScreenAddToCartFailedState({required this.message});
}
