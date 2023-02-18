import 'package:bloc/bloc.dart';
import 'package:khan_foods/Models/Product_By_Id_Model.dart';
import 'package:khan_foods/Models/Product_List_Model.dart';
import 'package:khan_foods/Utils/ApiServices/Api_Services.dart';
import 'package:meta/meta.dart';

part 'home_screen_product_event.dart';
part 'home_screen_product_state.dart';

class HomeScreenProductBloc
    extends Bloc<HomeScreenProductEvent, HomeScreenProductState> {
  HomeScreenProductBloc() : super(HomeScreenProductInitialState()) {
    on<HomeScreenCategoryFetchCategoryByIdSuccessfullyEvent>(
        (event, emit) async {
      emit.call(HomeScreenProductLoadingState());
      if (event.categoryId == 0) {
        try {
          List<ProductByIdModel> list = await ApiServices.getProductList();
          print("******************In**Bloc*************************");
          print(list[0].imageFile.toString());
          emit.call(HomeScreenCategoryByIdState(list: list));
        } catch (e) {
          emit.call(HomeScreenProductListFailedState(message: e.toString()));
        }
      } else {
        try {
          List<ProductByIdModel> list =
              await ApiServices.getProductById(event.categoryId);
          if (list.isNotEmpty) {
            emit.call(HomeScreenCategoryByIdState(list: list));
          } else {
            emit.call(HomeScreenEmptyListState());
          }
        } catch (e) {
          emit.call(HomeScreenProductListFailedState(message: e.toString()));
        }
      }

      /*
      try {
        List<ProductByIdModel> list =
            await ApiServices.getProductById(event.categoryId);
        if (list.isNotEmpty) {
          emit.call(HomeScreenCategoryByIdState(list: list));
        } else {
          emit.call(HomeScreenEmptyListState());
        }
      } catch (e) {
        emit.call(HomeScreenProductListFailedState(message: e.toString()));
      }
      */
    });
  }
}
