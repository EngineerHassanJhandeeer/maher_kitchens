import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khan_foods/Screens/Address_Page_Screen.dart';
import 'package:khan_foods/Widgets/Cart_Screen_Widget.dart';
import 'package:khan_foods/bloc/Cart_Bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartEmptyState) {
            return CartScreenEmptyUI();
          } else if (state is CartLoadedState) {
            return CartScreenLoadedUI(
              list: state.list,
              subtotalPrice: state.subTotalPrice,
              salesTax: state.salesTax,
              deliverCharges: state.deliverCharges,
              total: state.total,
            );
          } else if (state is CartDeleteAllItemState) {
            return CartScreenEmptyUI();
          } else if (state is CartDeleteSingleItemSate) {
            return CartScreenLoadedUI(
              list: state.list,
              subtotalPrice: state.subTotalPrice,
              salesTax: state.salesTax,
              deliverCharges: state.deliveryCharges,
              total: state.total,
            );
          } else if (state is CartAdditionOfQuantityState) {
            return CartScreenLoadedUI(
              list: state.list,
              subtotalPrice: state.subTotalPrice,
              salesTax: state.salesTax,
              deliverCharges: state.deliveryCharges,
              total: state.total,
            );
          } else if (state is CartSubtractionOfQuantityState) {
            return CartScreenLoadedUI(
              list: state.list,
              subtotalPrice: state.subTotalPrice,
              salesTax: state.salesTax,
              deliverCharges: state.deliveryCharges,
              total: state.total,
            );
          } else if (state is ProceedToCheckOutSuccessfullyState) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return AddreesPageScreen();
                },
              ));
            });
            return SizedBox();
          } else if (state is ProceedToCheckOutFailedState) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            });
            return SizedBox();
          } else {
            return Center(
              child: Text('Cart Builder Error'),
            );
          }
        },
      ),
    ));
  }
}
