// import 'package:bloc/bloc.dart';
// import 'package:khan_foods/Models/Product_Model.dart';
// import 'package:khan_foods/Utils/ApiServices/Api_Services.dart';
// import 'package:meta/meta.dart';

// part 'product_list_event.dart';
// part 'product_list_state.dart';

// class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
//   ProductListBloc() : super(ProductListInitialState()) {
//     on<ProductItemLisEvent>((event, emit) async {
//       List<ProductModel> list =
//           await ApiServices.getProductItemList(event.idNumber);
//       print('ProductList Bloc on ProductItemLisEvent  ${list}');
//       emit.call(ProductListLoadingState());
//       try {
//         await Future.delayed(Duration(seconds: 5));
//         emit.call(ProductListLoadedState(list: list));
//       } catch (e) {
//         emit.call(ProductListErroreState(message: e.toString()));
//       }
//     });

//     on<GetAllProducts>((event, emit) async {
//       List<ProductModel> list =
//           await ApiServices.getProductItemList(event.message);
//       emit.call(ProductListLoadingState());
//       print('ProductList Bloc on ProductItemLisEvent  ${list}');
//       try {
//         await Future.delayed(Duration(seconds: 3));
//         emit.call(ProductListLoadedState(list: list));
//       } catch (e) {
//         emit.call(ProductListErroreState(message: e.toString()));
//       }
//     });
//   }
// }
