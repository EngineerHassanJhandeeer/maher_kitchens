import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:khan_foods/Models/CartProduct_Model.dart';
import 'package:khan_foods/Models/Proced_To_Checkout_Model.dart';
import 'package:khan_foods/Utils/ApiServices/Api_Services.dart';
import 'package:khan_foods/Utils/Client_ID/Client_Id.dart';
import 'package:khan_foods/Utils/Local_Database/DbProvider.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  ProductDbProvider productDbProvider = ProductDbProvider();
  CartBloc() : super(CartEmptyState()) {
    on<CartEmptyEvent>((event, emit) {
      emit.call(CartEmptyState());
    });
    on<CartLoadedEvent>((event, emit) async {
      double sum = 0;
      double subTotalPrice = 0;
      double salesTax = 0;
      double deliveryCharges = 200;
      double total = 0;
      try {
        List<CartProductModel> list =
            await productDbProvider.fetchProductFromDb();
        // for (int i = 0; i < list.length; i++) {
        //   int a = list[i].quantity!;
        //   print(a);
        // }
        for (int i = 0; i < list.length; i++) {
          double a = list[i].price!;
          sum = sum + a;
        }
        subTotalPrice = sum;
        salesTax = (subTotalPrice * 10) / 100;
        print('sales tax is $salesTax');
        total = subTotalPrice + salesTax + deliveryCharges;
        //subtotal price=orderAmount
        //total=totalOrderAmount
        //salesTax=taxAmount
        int newSubTotalPrice =
            subTotalPrice.toInt(); //parsing to int from double
        int newTotal = total.toInt();
        int newSalesTax = salesTax.toInt();
        //insert in a new File to store and utilize it in next screen
        ClientId.orderAmount = newSubTotalPrice;
        ClientId.orderTotalAmount = newTotal;
        ClientId.taxAmount = newSalesTax;

        emit.call(CartLoadedState(
            list: list,
            subTotalPrice: subTotalPrice,
            salesTax: salesTax,
            deliverCharges: deliveryCharges,
            total: total));
      } catch (e) {
        emit.call(CartFailedState(message: 'Cart Bloc Error'));
      }
    });
    on<CartDeleteAllItemEvent>((event, emit) async {
      try {
        bool result = await productDbProvider.deleteAllProducts();
        if (result) {
          emit.call(CartEmptyState());
        } else {
          emit.call(CartFailedState(message: 'Can not delete all item'));
        }
      } catch (e) {
        emit.call(CartFailedState(message: 'Excepion of deltion all items'));
      }
    });

    on<CartDeleteSingleItemEvent>((event, emit) async {
      double sum = 0;
      double subTotalPrice = 0;
      double salesTax = 0;
      double deliveryCharges = 200;
      double total = 0;
      try {
        bool result =
            await productDbProvider.deleteProduct(event.cartProductModel);
        if (result) {
          try {
            List<CartProductModel> list =
                await productDbProvider.fetchProductFromDb();
            for (int i = 0; i < list.length; i++) {
              double a = list[i].price!;
              sum = sum + a;
            }
            subTotalPrice = sum;
            salesTax = (subTotalPrice * 10) / 100;
            total = subTotalPrice + salesTax + deliveryCharges;
            int newSubTotalPrice =
                subTotalPrice.toInt(); //parsing to int from double
            int newTotal = total.toInt();
            int newSalesTax = salesTax.toInt();
            //insert in a new File to store and utilize it in next screen
            ClientId.orderAmount = newSubTotalPrice;
            ClientId.orderTotalAmount = newTotal;
            ClientId.taxAmount = newSalesTax;
            if (list.isNotEmpty) {
              emit.call(CartLoadedState(
                  list: list,
                  subTotalPrice: subTotalPrice,
                  salesTax: salesTax,
                  deliverCharges: deliveryCharges,
                  total: total));
            } else {
              emit.call(CartEmptyState());
            }
          } catch (e) {
            emit.call(CartFailedState(message: 'Cart Bloc Error'));
          }
        } else {
          emit.call(CartFailedState(message: 'false delete bloc'));
        }
      } catch (e) {
        emit.call(CartFailedState(
            message: 'Delete Single Item Failed Bloc Exception'));
      }
    });

    on<CartAdditionOfQuantityEvent>((event, emit) async {
      double sum = 0;
      double subTotalPrice = 0;
      double salesTax = 0;
      double deliveryCharges = 200;
      double total = 0;
      try {
        int quantity = event.cartProductModel.quantity!;
        String productId = event.cartProductModel.productId!;
        double singleItemPrice = event.cartProductModel.singleItemPrice!;
        bool result = await productDbProvider.updateProduct(CartProductModel(
            productId: productId,
            quantity: quantity + 1,
            price: singleItemPrice * (quantity + 1)));
        if (result) {
          try {
            List<CartProductModel> list =
                await productDbProvider.fetchProductFromDb();
            for (int i = 0; i < list.length; i++) {
              double a = list[i].price!;
              sum = sum + a;
            }
            subTotalPrice = sum;
            salesTax = (subTotalPrice * 10) / 100;
            total = subTotalPrice + salesTax + deliveryCharges;
            int newSubTotalPrice =
                subTotalPrice.toInt(); //parsing to int from double
            int newTotal = total.toInt();
            int newSalesTax = salesTax.toInt();
            //insert in a new File to store and utilize it in next screen
            ClientId.orderAmount = newSubTotalPrice;
            ClientId.orderTotalAmount = newTotal;
            ClientId.taxAmount = newSalesTax;
            emit.call(CartAdditionOfQuantityState(
                list: list,
                subTotalPrice: subTotalPrice,
                salesTax: salesTax,
                deliveryCharges: deliveryCharges,
                total: total));
          } catch (e) {
            emit.call(CartFailedState(message: 'Cart Bloc Error'));
          }
        } else {
          emit.call(CartFailedState(message: 'false delete bloc'));
        }
      } catch (e) {
        CartFailedState(message: 'Addition Exception');
      }
    });
    on<CartSubtractionOfQuantityEvent>((event, emit) async {
      double sum = 0;
      double subTotalPrice = 0;
      double salesTax = 0;
      double deliveryCharges = 200;
      double total = 0;
      try {
        int quantity = event.cartProductModel.quantity!;
        String productId = event.cartProductModel.productId!;
        double singleItemPrice = event.cartProductModel.singleItemPrice!;
        double price = event.cartProductModel.price!;
        if (quantity > 1) {
          bool result = await productDbProvider.updateProduct(CartProductModel(
              productId: productId,
              quantity: quantity - 1,
              price: price - singleItemPrice));
          if (result) {
            try {
              List<CartProductModel> list =
                  await productDbProvider.fetchProductFromDb();
              for (int i = 0; i < list.length; i++) {
                double a = list[i].price!;
                sum = sum + a;
              }
              subTotalPrice = sum;
              salesTax = (subTotalPrice * 10) / 100;
              total = subTotalPrice + salesTax + deliveryCharges;
              int newSubTotalPrice =
                  subTotalPrice.toInt(); //parsing to int from double
              int newTotal = total.toInt();
              int newSalesTax = salesTax.toInt();
              //insert in a new File to store and utilize it in next screen
              ClientId.orderAmount = newSubTotalPrice;
              ClientId.orderTotalAmount = newTotal;
              ClientId.taxAmount = newSalesTax;
              emit.call(CartSubtractionOfQuantityState(
                  list: list,
                  subTotalPrice: subTotalPrice,
                  salesTax: salesTax,
                  deliveryCharges: deliveryCharges,
                  total: total));
            } catch (e) {
              emit.call(CartFailedState(message: 'Cart Bloc Error'));
            }
          } else {
            emit.call(CartFailedState(message: 'false delete bloc'));
          }
        }
      } catch (e) {
        CartFailedState(message: 'Addition Exception');
      }
    });

    on<ProceedToCheckOutSuccessfullyEvent>((event, emit) async {
      //ApiServices apiServices = ApiService();
      List<ProceedToCheckOutModel> list = [];

      try {
        List<CartProductModel> cartProductList = event.list;

        for (int i = 0; i < cartProductList.length; i++) {
          String productId = cartProductList[i].productId!;
          double price = cartProductList[i].price!;
          int? quantity = cartProductList[i].quantity!;
          int? myProductId = int.parse(productId);
          int? newPrice = price.toInt();
          int? orderId = 0;
          list.add(ProceedToCheckOutModel(
              orderId: orderId,
              productId: myProductId,
              price: newPrice,
              quantity: quantity));
        }
        try {
          Map<String, dynamic> data =
              await ApiServices.proceedToCheckOutOrder(list);
          if (data['Status'] == 'Order Detail Insertion Failed') {
            emit.call(
                ProceedToCheckOutFailedState(message: 'Sorry can not proceed'));
          } else if (data['Status'] == 'Inserted Successfully') {
            emit.call(ProceedToCheckOutSuccessfullyState());
          } else {
            emit.call(ProceedToCheckOutFailedState(message: 'else bloc'));
          }
        } catch (e) {
          emit.call(ProceedToCheckOutFailedState(
              message: 'Proceed To Checkout 2nd try Exception'));
        }
      } catch (e) {
        emit.call(ProceedToCheckOutFailedState(message: 'Proceed Exception'));
      }
    });
  }
}
