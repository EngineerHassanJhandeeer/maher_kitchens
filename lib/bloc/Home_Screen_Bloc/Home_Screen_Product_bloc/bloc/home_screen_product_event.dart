part of 'home_screen_product_bloc.dart';

@immutable
abstract class HomeScreenProductEvent {}

class HomeScreenFetchProductInitialEvent extends HomeScreenProductEvent {}

class HomeScreenFetchProductListSuccessfullyEvent
    extends HomeScreenProductEvent {}

class HomeScreenCategoryFetchCategoryByIdSuccessfullyEvent
    extends HomeScreenProductEvent {
  final int categoryId;
  HomeScreenCategoryFetchCategoryByIdSuccessfullyEvent(
      {required this.categoryId});
}
