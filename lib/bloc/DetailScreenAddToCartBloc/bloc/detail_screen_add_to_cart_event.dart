part of 'detail_screen_add_to_cart_bloc.dart';

@immutable
abstract class DetailScreenAddToCartEvent {}

class DetailScreenAddToCartInitialEvent extends DetailScreenAddToCartEvent {}

class DetailScreenAddToCartSuccessfullyEvent
    extends DetailScreenAddToCartEvent {
  final CartProductModel cartProductModel;
  DetailScreenAddToCartSuccessfullyEvent({required this.cartProductModel});
}
