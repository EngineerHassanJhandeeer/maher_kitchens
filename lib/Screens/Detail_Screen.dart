import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khan_foods/Screens/Home_Screen.dart';
import 'package:khan_foods/Widgets/Custom_Drawer.dart';
import 'package:khan_foods/Widgets/Detail_Screen_Widget.dart';
import 'package:khan_foods/bloc/DetailScreenAddToCartBloc/bloc/detail_screen_add_to_cart_bloc.dart';

import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> state = GlobalKey<ScaffoldState>();
  String image_Url;
  String name;
  double? price;
  int? productId;
  String? catagoryId;
  String? description;

  DetailScreen({
    required this.image_Url,
    required this.name,
    required this.price,
    required this.productId,
    required this.catagoryId,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final detailScreenBloc =
        Provider.of<DetailScreenAddToCartBloc>(context, listen: false);
    detailScreenBloc.add(DetailScreenAddToCartInitialEvent());
    return SafeArea(
        child: Scaffold(
      key: state,
      drawer: AppDrawer(),
      body: BlocBuilder<DetailScreenAddToCartBloc, DetailScreenAddToCartState>(
        builder: (context, state) {
          if (state is DetailScreenAddToCartInitialState) {
            return Detailcreen_UI(
                image_Url: image_Url,
                name: name,
                price: price,
                productId: productId,
                catagoryId: catagoryId,
                description: description);
          } else if (state is DetailScreenAddToCartSuccessfullyState) {
            detailScreenBloc.add(DetailScreenAddToCartInitialEvent());
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            });
            return Detailcreen_UI(
                image_Url: image_Url,
                name: name,
                price: price,
                productId: productId,
                catagoryId: catagoryId,
                description: description);
          } else if (state is DetailScreenAddToCartFailedState) {
            detailScreenBloc.add(DetailScreenAddToCartInitialEvent());
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            });
            return Detailcreen_UI(
                image_Url: image_Url,
                name: name,
                price: price,
                productId: productId,
                catagoryId: catagoryId,
                description: description);
          } else {
            return const Center(
              child: Text('No Screen'),
            );
          }
        },
      ),
    ));
  }
}
