import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khan_foods/Models/CartProduct_Model.dart';
import 'package:khan_foods/Screens/Home_Screen.dart';
import 'package:khan_foods/Utils/Local_Database/DbHandler.dart';
import 'package:khan_foods/Utils/Local_Database/DbProvider.dart';
import 'package:khan_foods/bloc/Cart_Bloc/cart_bloc.dart';
import 'package:khan_foods/bloc/Home_Screen_Bloc/Home_Screen_Category_bloc/home_screen_category_bloc.dart';
import 'package:khan_foods/bloc/Home_Screen_Bloc/Home_Screen_Product_bloc/bloc/home_screen_product_bloc.dart';
import 'package:khan_foods/bloc/ItemList_Bloc/bloc/item_list_bloc.dart';
import 'package:khan_foods/bloc/ProductList_Bloc/product_list_bloc.dart';

import 'package:provider/provider.dart';

class CartScreenEmptyUI extends StatelessWidget {
  const CartScreenEmptyUI({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;
        return Container(
          color: Colors.brown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //space
              SizedBox(
                height: height * 0.38,
              ),
              //Text
              SizedBox(
                height: height * 0.15,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                  child: Text(
                    'Alas! Your Cart is Empty,Please Add some Product Items to your Cart before Checkout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white54, fontSize: height * 0.027),
                  ),
                ),
              ),
              //Space
              SizedBox(
                height: height * 0.38,
              ),
              InkWell(
                onTap: () {
                  // 1
                  Provider.of<HomeScreenProductBloc>(context, listen: false)
                      .add(HomeScreenCategoryFetchCategoryByIdSuccessfullyEvent(
                          categoryId: 0));
                  // Provider.of<ProductListBloc>(context, listen: false)
                  //     .add(ProductItemListEvent(idNumber: 0.toString()));
                  // 2
                  Provider.of<HomeScreenCategoryBloc>(context, listen: false).add(
                      HomeScreenCategoryFetchCategoryListSuccessfullyEvent());
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return HomePageScreen();
                      },
                    ));
                  });
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 0.75,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(height * 0.02)),
                  child: Center(
                    child: Text(
                      'Explore Products',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: height * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        );
      },
    );
  }
}

class CartScreenLoadedUI extends StatefulWidget {
  List<CartProductModel> list;
  double subtotalPrice;
  double salesTax;
  double deliverCharges;
  double total;

  CartScreenLoadedUI(
      {Key? key,
      required this.list,
      required this.subtotalPrice,
      required this.salesTax,
      required this.deliverCharges,
      required this.total})
      : super(key: key);

  @override
  State<CartScreenLoadedUI> createState() => _CartScreenLoadedUIState();
}

class _CartScreenLoadedUIState extends State<CartScreenLoadedUI> {
  ProductDbProvider productDbProvider = ProductDbProvider();
  //D bHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;
        return Container(
          color: Colors.brown,
          child: Column(
            children: [
              //row
              SizedBox(
                height: height * 0.1,
                child: Row(
                  children: [
                    //text
                    SizedBox(
                      width: width * 0.3,
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.04),
                        child: Text(
                          'My Cart',
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.03),
                        ),
                      ),
                    ),
                    //space
                    SizedBox(
                      width: width * 0.48,
                    ),
                    //icon
                    SizedBox(
                      width: width * 0.2,
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.02),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //row
              SizedBox(
                height: height * 0.1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.2,
                        child: Text(
                          'All List',
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.025),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.2,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<CartBloc>(context, listen: false)
                                .add(CartDeleteAllItemEvent());
                          },
                          child: Text(
                            'Clear All',
                            style: TextStyle(
                                color: Colors.white, fontSize: height * 0.022),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //listview builder
              SizedBox(
                height: height * 0.5,
                child: ListView.builder(
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) {
                    String urlOfImage =
                        widget.list[index].pictureUrl.toString();
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.01, vertical: height * 0.01),
                      child: Container(
                        height: height * 0.2,
                        color: Colors.brown.shade900,
                        child: Row(
                          children: [
                            //image
                            SizedBox(
                              width: width * 0.3,
                              child: Padding(
                                padding: EdgeInsets.only(left: width * 0.02),
                                child: urlOfImage == "https://food.elms.pk/"
                                    ? Center(
                                        child:
                                            Image.asset('assets/image/d7.gif'),
                                        // Text(
                                        //   'Processing',
                                        //   style: TextStyle(
                                        //       fontSize: 16, color: Colors.white),
                                        // ),
                                      )
                                    : Image.network(urlOfImage),
                                // CachedNetworkImage(
                                //   imageUrl:
                                //       'https://food.elms.pk${widget.list[index].pictureUrl}' ??
                                //           '',
                                //   imageBuilder: (context, imageProvider) =>
                                //       Container(
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image: imageProvider,
                                //       ),
                                //     ),
                                //   ),
                                //   placeholder: (context, url) => Center(
                                //       child: CircularProgressIndicator()),
                                //   errorWidget: (context, url, error) =>
                                //       Icon(Icons.error),
                                // ),
                              ),
                            ),
                            //space
                            SizedBox(
                              width: width * 0.03,
                            ),
                            //Column
                            Padding(
                              padding: EdgeInsets.only(
                                top: height * 0.04,
                              ),
                              child: SizedBox(
                                width: width * 0.65,
                                child: Column(
                                  children: [
                                    //1st row name and delete option
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          //text
                                          SizedBox(
                                            width: width * 0.40,
                                            child: Text(
                                              widget.list[index].productName
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          //space
                                          SizedBox(
                                            width: width * 0.05,
                                          ),
                                          //icon delete
                                          SizedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                Provider.of<CartBloc>(context,
                                                        listen: false)
                                                    .add(CartDeleteSingleItemEvent(
                                                        cartProductModel:
                                                            CartProductModel(
                                                                productId: widget
                                                                    .list[index]
                                                                    .productId)));
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    //2nd row,add or minus quantity and price
                                    SizedBox(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.05),
                                        child: Row(
                                          children: [
                                            //space
                                            SizedBox(
                                              width: width * 0.03,
                                            ),
                                            //icon subtraction
                                            SizedBox(
                                              width: width * 0.1,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Provider.of<CartBloc>(
                                                            context,
                                                            listen: false)
                                                        .add(CartSubtractionOfQuantityEvent(
                                                            cartProductModel: CartProductModel(
                                                                productId: widget
                                                                    .list[index]
                                                                    .productId,
                                                                quantity: widget
                                                                    .list[index]
                                                                    .quantity,
                                                                price: widget
                                                                    .list[index]
                                                                    .price,
                                                                singleItemPrice:
                                                                    widget
                                                                        .list[
                                                                            index]
                                                                        .singleItemPrice)));
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //text quantity
                                            SizedBox(
                                              width: width * 0.15,
                                              child: Center(
                                                child: Text(
                                                  widget.list[index].quantity
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            //icon add
                                            SizedBox(
                                              width: width * 0.1,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Provider.of<CartBloc>(
                                                            context,
                                                            listen: false)
                                                        .add(
                                                            CartAdditionOfQuantityEvent(
                                                      cartProductModel:
                                                          CartProductModel(
                                                              productId: widget
                                                                  .list[index]
                                                                  .productId,
                                                              quantity: widget
                                                                  .list[index]
                                                                  .quantity,
                                                              price:
                                                                  widget
                                                                      .list[
                                                                          index]
                                                                      .price,
                                                              singleItemPrice:
                                                                  widget
                                                                      .list[
                                                                          index]
                                                                      .singleItemPrice),
                                                    ));
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //text price
                                            SizedBox(
                                              width: width * 0.2,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.04),
                                                child: Text(
                                                  widget.list[index].price
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: height * 0.02),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              //calculation
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Container(
                  color: Colors.brown.shade300,
                  height: height * 0.2,
                  child: Column(
                    children: [
                      //total row
                      SizedBox(
                        height: height * 0.05,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.2,
                                child: Text(
                                  'Sub Total:',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.15,
                                child: Text(
                                  widget.subtotalPrice.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //sales tax row
                      SizedBox(
                        height: height * 0.05,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: Text(
                                  'Sales Tax:',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.15,
                                child: Text(
                                  widget.salesTax.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //delivery charges row
                      SizedBox(
                        height: height * 0.05,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.4,
                                child: Text(
                                  'Delivery Charges:',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.15,
                                child: Text(
                                  widget.deliverCharges.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //toatal row
                      SizedBox(
                        height: height * 0.05,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.2,
                                child: Text(
                                  'Total:',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.15,
                                child: Text(
                                  widget.total.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //space
              SizedBox(
                height: height * 0.015,
              ),
              //button
              GestureDetector(
                onTap: () async {
                  List<CartProductModel> list =
                      await productDbProvider.fetchProductFromDb();
                  Provider.of<CartBloc>(context, listen: false)
                      .add(ProceedToCheckOutSuccessfullyEvent(list: list));
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 0.75,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(height * 0.02),
                  ),
                  child: Center(
                    child: Text(
                      'Proceed To CheckOut',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: height * 0.022,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              //space
              SizedBox(
                height: height * 0.015,
              ),
            ],
          ),
        );
      },
    );

    // LayoutBuilder(
    //   builder: (BuildContext context, BoxConstraints constraints) {
    //     double height = constraints.maxHeight;
    //     double width = constraints.maxWidth;
    //     return Container(
    //       color: Colors.brown,
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           //row
    //           SizedBox(
    //             height: height * 0.1,
    //             child: Row(
    //               children: [
    //                 //text
    //                 SizedBox(
    //                   width: width * 0.3,
    //                   child: Padding(
    //                     padding: EdgeInsets.only(left: width * 0.04),
    //                     child: Text(
    //                       'My Cart',
    //                       style: TextStyle(
    //                           color: Colors.white, fontSize: height * 0.03),
    //                     ),
    //                   ),
    //                 ),
    //                 //space
    //                 SizedBox(
    //                   width: width * 0.48,
    //                 ),
    //                 //icon
    //                 SizedBox(
    //                   width: width * 0.2,
    //                   child: Padding(
    //                     padding: EdgeInsets.only(left: width * 0.02),
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         Navigator.pop(context);
    //                       },
    //                       child: Icon(
    //                         Icons.close,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           //row
    //           SizedBox(
    //             height: height * 0.1,
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(horizontal: width * 0.05),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   SizedBox(
    //                     width: width * 0.2,
    //                     child: Text(
    //                       'All List',
    //                       style: TextStyle(
    //                           color: Colors.white, fontSize: height * 0.025),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     width: width * 0.2,
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         Provider.of<CartBloc>(context, listen: false)
    //                             .add(CartDeleteAllItemEvent());
    //                       },
    //                       child: Text(
    //                         'Clear All',
    //                         style: TextStyle(
    //                             color: Colors.white, fontSize: height * 0.022),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           //listview builder
    //           SizedBox(
    //             height: height * 0.5,
    //             child: ListView.builder(
    //               itemCount: widget.list.length,
    //               itemBuilder: (context, index) {
    //                 String urlOfImage =
    //                     widget.list[index].pictureUrl.toString();
    //                 return Padding(
    //                   padding: EdgeInsets.symmetric(
    //                       horizontal: width * 0.01, vertical: height * 0.01),
    //                   child: Container(
    //                     height: height * 0.2,
    //                     color: Colors.brown.shade900,
    //                     child: Row(
    //                       children: [
    //                         //image

    //                         // SizedBox(
    //                         //   height: height * 0.3,
    //                         //   width: double.infinity,
    //                         //   child: Padding(
    //                         //     padding: EdgeInsets.only(left: width * 0.02),
    //                         //     child: Card(
    //                         //       elevation: 22,
    //                         //       color: Colors.transparent,
    //                         //       child: widget.list ==
    //                         //               "https://food.elms.pk/" + urlOfImage
    //                         //           ? const Center(
    //                         //               child: Text(
    //                         //                 'Processing',
    //                         //                 style: TextStyle(
    //                         //                     fontSize: 16,
    //                         //                     color: Colors.white),
    //                         //               ),
    //                         //             )
    //                         //           : Image.network(widget.list.toString()),
    //                         //     ),
    //                         //   ),
    //                         // ),
    //                         SizedBox(
    //                           width: width * 0.5,
    //                           child: Padding(
    //                             padding: EdgeInsets.only(left: width * 0.02),
    //                             child: Padding(
    //                               padding: EdgeInsets.only(left: width * 0.02),
    //                               child: Card(
    //                                 elevation: 22,
    //                                 color: Colors.transparent,
    //                                 child: urlOfImage ==
    //                                         "https://food.elms.pk/" + urlOfImage
    //                                     ? const Center(
    //                                         child: Text(
    //                                           'Processing',
    //                                           style: TextStyle(
    //                                               fontSize: 16,
    //                                               color: Colors.white),
    //                                         ),
    //                                       )
    //                                     : Image.network(urlOfImage),
    //                               ),
    //                             ),

    //                             // child:
    //                             // CachedNetworkImage(
    //                             //   imageUrl:
    //                             //       'https://food.elms.pk${widget.list[index].pictureUrl}' ??
    //                             //           '',
    //                             //   imageBuilder: (context, imageProvider) =>
    //                             //       Container(
    //                             //     decoration: BoxDecoration(
    //                             //       image: DecorationImage(
    //                             //         image: imageProvider,
    //                             //       ),
    //                             //     ),
    //                             //   ),
    //                             //   placeholder: (context, url) => Center(
    //                             //       child: CircularProgressIndicator()),
    //                             //   errorWidget: (context, url, error) =>
    //                             //       Icon(Icons.error),
    //                             // ),
    //                           ),
    //                         ),
    //                         //space
    //                         SizedBox(
    //                           width: width * 0.03,
    //                         ),
    //                         //Column
    //                         Padding(
    //                           padding: EdgeInsets.only(
    //                             top: height * 0.04,
    //                           ),
    //                           child: SizedBox(
    //                             width: width * 0.65,
    //                             child: Column(
    //                               children: [
    //                                 //1st row name and delete option
    //                                 SizedBox(
    //                                   child: Row(
    //                                     children: [
    //                                       //text
    //                                       SizedBox(
    //                                         width: width * 0.40,
    //                                         child: Text(
    //                                           widget.list[index].productName
    //                                               .toString(),
    //                                           style: TextStyle(
    //                                               color: Colors.white),
    //                                         ),
    //                                       ),
    //                                       //space
    //                                       SizedBox(
    //                                         width: width * 0.05,
    //                                       ),
    //                                       //icon delete
    //                                       SizedBox(
    //                                         child: GestureDetector(
    //                                           onTap: () {
    //                                             Provider.of<CartBloc>(context,
    //                                                     listen: false)
    //                                                 .add(CartDeleteSingleItemEvent(
    //                                                     cartProductModel:
    //                                                         CartProductModel(
    //                                                             productId: widget
    //                                                                 .list[index]
    //                                                                 .productId)));
    //                                           },
    //                                           child: Icon(
    //                                             Icons.delete,
    //                                             color: Colors.white,
    //                                           ),
    //                                         ),
    //                                       )
    //                                     ],
    //                                   ),
    //                                 ),
    //                                 //2nd row,add or minus quantity and price
    //                                 SizedBox(
    //                                   child: Padding(
    //                                     padding:
    //                                         EdgeInsets.only(top: height * 0.05),
    //                                     child: Row(
    //                                       children: [
    //                                         //space
    //                                         SizedBox(
    //                                           width: width * 0.03,
    //                                         ),
    //                                         //icon subtraction
    //                                         SizedBox(
    //                                           width: width * 0.1,
    //                                           child: Align(
    //                                             alignment:
    //                                                 Alignment.centerRight,
    //                                             child: GestureDetector(
    //                                               onTap: () {
    //                                                 Provider.of<CartBloc>(
    //                                                         context,
    //                                                         listen: false)
    //                                                     .add(CartSubtractionOfQuantityEvent(
    //                                                         cartProductModel: CartProductModel(
    //                                                             productId: widget
    //                                                                 .list[index]
    //                                                                 .productId,
    //                                                             quantity: widget
    //                                                                 .list[index]
    //                                                                 .quantity,
    //                                                             price: widget
    //                                                                 .list[index]
    //                                                                 .price,
    //                                                             singleItemPrice:
    //                                                                 widget
    //                                                                     .list[
    //                                                                         index]
    //                                                                     .singleItemPrice)));
    //                                               },
    //                                               child: Icon(
    //                                                 Icons.remove,
    //                                                 color: Colors.white,
    //                                               ),
    //                                             ),
    //                                           ),
    //                                         ),
    //                                         //text quantity
    //                                         SizedBox(
    //                                           width: width * 0.15,
    //                                           child: Center(
    //                                             child: Text(
    //                                               widget.list[index].quantity
    //                                                   .toString(),
    //                                               style: TextStyle(
    //                                                   color: Colors.white),
    //                                             ),
    //                                           ),
    //                                         ),
    //                                         //icon add
    //                                         SizedBox(
    //                                           width: width * 0.1,
    //                                           child: Align(
    //                                             alignment: Alignment.centerLeft,
    //                                             child: GestureDetector(
    //                                               onTap: () {
    //                                                 Provider.of<CartBloc>(
    //                                                         context,
    //                                                         listen: false)
    //                                                     .add(
    //                                                         CartAdditionOfQuantityEvent(
    //                                                   cartProductModel:
    //                                                       CartProductModel(
    //                                                           productId: widget
    //                                                               .list[index]
    //                                                               .productId,
    //                                                           quantity: widget
    //                                                               .list[index]
    //                                                               .quantity,
    //                                                           price:
    //                                                               widget
    //                                                                   .list[
    //                                                                       index]
    //                                                                   .price,
    //                                                           singleItemPrice:
    //                                                               widget
    //                                                                   .list[
    //                                                                       index]
    //                                                                   .singleItemPrice),
    //                                                 ));
    //                                               },
    //                                               child: Icon(
    //                                                 Icons.add,
    //                                                 color: Colors.white,
    //                                               ),
    //                                             ),
    //                                           ),
    //                                         ),
    //                                         //text price
    //                                         SizedBox(
    //                                           width: width * 0.2,
    //                                           child: Padding(
    //                                             padding: EdgeInsets.only(
    //                                                 left: width * 0.04),
    //                                             child: Text(
    //                                               widget.list[index].price
    //                                                   .toString(),
    //                                               style: TextStyle(
    //                                                   color: Colors.white,
    //                                                   fontWeight:
    //                                                       FontWeight.bold,
    //                                                   fontSize: height * 0.02),
    //                                             ),
    //                                           ),
    //                                         )
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //           //calculation
    //           Padding(
    //             padding: EdgeInsets.symmetric(horizontal: width * 0.03),
    //             child: Container(
    //               color: Colors.brown.shade300,
    //               height: height * 0.2,
    //               child: Column(
    //                 children: [
    //                   //total row
    //                   SizedBox(
    //                     height: height * 0.05,
    //                     child: Padding(
    //                       padding:
    //                           EdgeInsets.symmetric(horizontal: width * 0.05),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           SizedBox(
    //                             width: width * 0.2,
    //                             child: Text(
    //                               'Sub Total:',
    //                               style: TextStyle(color: Colors.white),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             width: width * 0.15,
    //                             child: Text(
    //                               widget.subtotalPrice.toString(),
    //                               style: TextStyle(color: Colors.white),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   //sales tax row
    //                   SizedBox(
    //                     height: height * 0.05,
    //                     child: Padding(
    //                       padding:
    //                           EdgeInsets.symmetric(horizontal: width * 0.05),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           SizedBox(
    //                             width: width * 0.3,
    //                             child: Text(
    //                               'Sales Tax:',
    //                               style: TextStyle(color: Colors.white),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             width: width * 0.15,
    //                             child: Text(
    //                               widget.salesTax.toString(),
    //                               style: TextStyle(color: Colors.white),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   //delivery charges row
    //                   SizedBox(
    //                     height: height * 0.05,
    //                     child: Padding(
    //                       padding:
    //                           EdgeInsets.symmetric(horizontal: width * 0.05),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           SizedBox(
    //                             width: width * 0.4,
    //                             child: Text(
    //                               'Delivery Charges:',
    //                               style: TextStyle(color: Colors.white),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             width: width * 0.15,
    //                             child: Text(
    //                               widget.deliverCharges.toString(),
    //                               style: TextStyle(color: Colors.white),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   //toatal row
    //                   SizedBox(
    //                     height: height * 0.05,
    //                     child: Padding(
    //                       padding:
    //                           EdgeInsets.symmetric(horizontal: width * 0.05),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           SizedBox(
    //                             width: width * 0.2,
    //                             child: Text(
    //                               'Total:',
    //                               style: TextStyle(color: Colors.white),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             width: width * 0.15,
    //                             child: Text(
    //                               widget.total.toString(),
    //                               style: TextStyle(color: Colors.white),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           //space
    //           SizedBox(
    //             height: height * 0.015,
    //           ),
    //           //button
    //           GestureDetector(
    //             onTap: () async {
    //               List<CartProductModel> list =
    //                   await productDbProvider.fetchProductFromDb();
    //               Provider.of<CartBloc>(context, listen: false)
    //                   .add(ProceedToCheckOutSuccessfullyEvent(list: list));
    //             },
    //             child: Container(
    //               height: height * 0.07,
    //               width: width * 0.75,
    //               decoration: BoxDecoration(
    //                 color: Colors.yellow,
    //                 borderRadius: BorderRadius.circular(height * 0.02),
    //               ),
    //               child: Center(
    //                 child: Text(
    //                   'Proceed To CheckOut',
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: height * 0.022,
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           //space
    //           SizedBox(
    //             height: height * 0.015,
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
