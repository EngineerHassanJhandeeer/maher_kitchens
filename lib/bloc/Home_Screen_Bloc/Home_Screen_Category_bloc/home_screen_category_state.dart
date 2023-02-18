part of 'home_screen_category_bloc.dart';

@immutable
abstract class HomeScreenCategoryState {}

class HomeScreenCategoryItemListInitialState extends HomeScreenCategoryState {}

class HomeScreenCategoryItemListLoadingState extends HomeScreenCategoryState {}

class HomeScreenCategoryItemListSuccessfullyLoadedState
    extends HomeScreenCategoryState {
  final List<CategoryModel> list;
  HomeScreenCategoryItemListSuccessfullyLoadedState({required this.list});
}

class HomeScreenCategoryItemListFailedState extends HomeScreenCategoryState {
  final String message;
  HomeScreenCategoryItemListFailedState({required this.message});
}
