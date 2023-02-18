// import 'package:bloc/bloc.dart';
// import 'package:http/http.dart';
// import 'package:khan_foods/Models/Product_List_Model.dart';
// import 'package:khan_foods/Utils/ApiServices/Api_Services.dart';
// import 'package:meta/meta.dart';

// part 'item_list_event.dart';
// part 'item_list_state.dart';

// class ItemListBloc extends Bloc<ItemListEvent, ItemListState> {
//   ItemListBloc() : super(ItemListInitialState()) {
//     on<GetItemEvent>((event, emit) async {
//       emit.call(ItemlistLoadingState());
//       var<ProductListModel> list = await ApiServices.getProductList();
//       print('ItemList Bloc ${list}');
//       try {
//         await Future.delayed(Duration(seconds: 5));
//         emit.call(
//             ItemListLoadedState(itemList: await ApiServices.getProductList()));
//       } catch (e) {
//         emit.call(ItemListErrorState(message: e.toString()));
//       }
//     });
//   }
// }
