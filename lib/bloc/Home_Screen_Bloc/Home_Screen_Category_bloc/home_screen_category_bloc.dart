import 'package:bloc/bloc.dart';
import 'package:khan_foods/Models/Catgory_Model.dart';
import 'package:khan_foods/Utils/ApiServices/Api_Services.dart';
import 'package:meta/meta.dart';

part 'home_screen_category_event.dart';
part 'home_screen_category_state.dart';

class HomeScreenCategoryBloc
    extends Bloc<HomeScreenCategoryEvent, HomeScreenCategoryState> {
  HomeScreenCategoryBloc() : super(HomeScreenCategoryItemListInitialState()) {
    on<HomeScreenCategoryFetchCategoryListSuccessfullyEvent>(
        (event, emit) async {
      emit.call(HomeScreenCategoryItemListLoadingState());
      try {
        List<CategoryModel> categoryItemList =
            await ApiServices.getCategoryList();

        emit.call(HomeScreenCategoryItemListSuccessfullyLoadedState(
            list: categoryItemList));
      } catch (e) {
        emit.call(HomeScreenCategoryItemListFailedState(message: e.toString()));
      }
    });
  }
}
