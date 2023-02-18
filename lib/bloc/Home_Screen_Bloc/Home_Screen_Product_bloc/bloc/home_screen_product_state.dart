part of 'home_screen_product_bloc.dart';

@immutable
abstract class HomeScreenProductState {}

class HomeScreenProductInitialState extends HomeScreenProductState {}

class HomeScreenProductLoadingState extends HomeScreenProductState {}

class HomeScreenProductListSuccessfullyState extends HomeScreenProductState {
  final List<ProductListModel> list;
  HomeScreenProductListSuccessfullyState({required this.list});
}

class HomeScreenProductListFailedState extends HomeScreenProductState {
  final String message;
  HomeScreenProductListFailedState({required this.message});
}

//
class HomeScreenCategoryByIdState extends HomeScreenProductState {
  List<ProductByIdModel> list;
  HomeScreenCategoryByIdState({required this.list});
}

class HomeScreenEmptyListState extends HomeScreenProductState {}
