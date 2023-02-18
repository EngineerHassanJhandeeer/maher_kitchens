part of 'home_screen_category_bloc.dart';

@immutable
abstract class HomeScreenCategoryEvent {}

class HomeScreenCategoryInitialEvent extends HomeScreenCategoryEvent {}

class HomeScreenCategoryLoadingEvent extends HomeScreenCategoryEvent {}

class HomeScreenCategoryFetchCategoryListSuccessfullyEvent
    extends HomeScreenCategoryEvent {}
