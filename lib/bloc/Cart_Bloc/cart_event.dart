part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartEmptyEvent extends CartEvent {}

class CartLoadedEvent extends CartEvent {}

class CartDeleteAllItemEvent extends CartEvent {}

class CartDeleteSingleItemEvent extends CartEvent {
  final CartProductModel cartProductModel;
  CartDeleteSingleItemEvent({required this.cartProductModel});
}

class CartAdditionOfQuantityEvent extends CartEvent {
  final CartProductModel cartProductModel;
  CartAdditionOfQuantityEvent({required this.cartProductModel});
}

class CartSubtractionOfQuantityEvent extends CartEvent {
  final CartProductModel cartProductModel;
  CartSubtractionOfQuantityEvent({required this.cartProductModel});
}

class FetchAllPricesSuccessfullyEvent extends CartEvent {}

class ProceedToCheckOutSuccessfullyEvent extends CartEvent {
  List<CartProductModel> list;
  ProceedToCheckOutSuccessfullyEvent({required this.list});
}
