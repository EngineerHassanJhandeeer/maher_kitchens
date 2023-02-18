import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khan_foods/Models/Product_List_Model.dart';
import 'package:khan_foods/Widgets/Custom_Drawer.dart';
import 'package:khan_foods/Widgets/HomePage_Screen_Widget.dart';
import 'package:khan_foods/bloc/Home_Screen_Bloc/Home_Screen_Category_bloc/home_screen_category_bloc.dart';
import 'package:khan_foods/bloc/Home_Screen_Bloc/Home_Screen_Product_bloc/bloc/home_screen_product_bloc.dart';
import 'package:khan_foods/bloc/ItemList_Bloc/bloc/item_list_bloc.dart';
import 'package:khan_foods/bloc/ProductList_Bloc/product_list_bloc.dart';

import 'package:provider/provider.dart';

class HomePageScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> state = GlobalKey<ScaffoldState>();
  HomePageScreen({this.email, super.key});
  String? email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: state,
      drawer: MyDrawer(
        email: email,
      ),
      backgroundColor: Colors.brown,
      body: LayoutBuilder(builder: (context, constraint) {
        double h = constraint.maxHeight;
        return Column(
          children: [
            SizedBox(height: h * 0.29, child: First()),
            SizedBox(height: h * 0.71, child: Second())
          ],
        );
      }),
    ));
  }
}

class First extends StatelessWidget {
  First({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeScreenCategoryBloc =
        Provider.of<HomeScreenCategoryBloc>(context, listen: false);
    homeScreenCategoryBloc
        .add(HomeScreenCategoryFetchCategoryListSuccessfullyEvent());
    return BlocBuilder<HomeScreenCategoryBloc, HomeScreenCategoryState>(
      builder: (context, state) {
        if (state is HomeScreenCategoryItemListLoadingState) {
          print('********************');
          print('Hassan in ItemListInitialState');
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeScreenCategoryItemListSuccessfullyLoadedState) {
          print('********************');
          print('Hassan in ItemlistLoadingState');
          return HomeScreenCategoryLoadedUI(
            list: state.list,
          );
        } else if (state is HomeScreenCategoryItemListFailedState) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          });
          return SizedBox();
        } else {
          return Center(child: Text('Builder Error'));
        }
      },
    );
  }
}

class Second extends StatelessWidget {
  Second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeScreenProductBloc =
        Provider.of<HomeScreenProductBloc>(context, listen: false);
    homeScreenProductBloc.add(
        HomeScreenCategoryFetchCategoryByIdSuccessfullyEvent(categoryId: 0));
    return BlocBuilder<HomeScreenProductBloc, HomeScreenProductState>(
      builder: (context, state) {
        if (state is HomeScreenProductLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeScreenCategoryByIdState) {
          return HomeScreenProductLoadedUI(list: state.list);
        } else if (state is HomeScreenProductListFailedState) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          });
          return SizedBox();
        } else if (state is HomeScreenCategoryByIdState) {
          print(state.list);
          return HomeScreenProductLoadedUI(
            list: state.list,
          );
        } else if (state is HomeScreenEmptyListState) {
          return HomeScreenProductNotAvailabelProductUI();
        } else {
          return Center(
            child: Text('Builder Error'),
          );
        }
      },
    );
  }
}
