import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:khan_foods/Models/CartProduct_Model.dart';
import 'package:khan_foods/Screens/Cart_Screen.dart';
import 'package:khan_foods/Utils/Local_Database/DbProvider.dart';
import 'package:khan_foods/Widgets/Custom_Drawer.dart';
import 'package:khan_foods/bloc/Cart_Bloc/cart_bloc.dart';
import 'package:khan_foods/bloc/DetailScreenAddToCartBloc/bloc/detail_screen_add_to_cart_bloc.dart';

import 'package:khan_foods/bloc/Home_Screen_Bloc/Home_Screen_Product_bloc/bloc/home_screen_product_bloc.dart';
import 'package:provider/provider.dart';

class Detailcreen_UI extends StatefulWidget {
  String image_Url;
  String name;
  double? price;
  int? productId;
  String? catagoryId;
  String? description;

  Detailcreen_UI({
    required this.image_Url,
    required this.name,
    required this.price,
    required this.productId,
    required this.catagoryId,
    required this.description,
    super.key,
  });

  @override
  State<Detailcreen_UI> createState() => _Detailcreen_UIState();
}

class _Detailcreen_UIState extends State<Detailcreen_UI> {
  ProductDbProvider productDbProvider = ProductDbProvider();
  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    //double w = MediaQuery.of(context).size.width;
    // GlobalKey<ScaffoldState> state = GlobalKey<ScaffoldState>();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;
        return Container(
          color: Colors.brown,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              //row
              SizedBox(
                height: height * 0.1,
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.05,
                    ),
                    SizedBox(
                      width: width * 0.1,
                      child: InkWell(
                        onTap: () {
                          Provider.of<HomeScreenProductBloc>(context,
                                  listen: false)
                              .add(
                                  HomeScreenCategoryFetchCategoryByIdSuccessfullyEvent(
                                      categoryId: 0));
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.7,
                    ),
                    SizedBox(
                      width: width * 0.1,
                      child: InkWell(
                        onTap: () async {
                          List<CartProductModel> list =
                              await productDbProvider.fetchProductFromDb();
                          if (list.isEmpty) {
                            Provider.of<CartBloc>(context, listen: false)
                                .add(CartEmptyEvent());
                            SchedulerBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return CartScreen();
                                },
                              ));
                            });
                          } else {
                            Provider.of<CartBloc>(context, listen: false)
                                .add(CartLoadedEvent());
                            SchedulerBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return CartScreen();
                                },
                              ));
                            });
                          }
                        },
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    )
                  ],
                ),
              ),
              //pic
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Container(
                  height: height * 0.3,
                  color: Colors.brown.shade200,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.004,
                        bottom: height * 0.004,
                      ),
                      child: widget.image_Url == "https://food.elms.pk/"
                          ? Center(
                              child: Image.asset('assets/image/d5.gif'),
                              // Text(
                              //   'Processing',
                              //   style: TextStyle(
                              //       fontSize: 16, color: Colors.white),
                              // ),
                            )
                          : Image.network(widget.image_Url),
                      // CachedNetworkImage(
                      //   imageUrl: 'https://food.elms.pk${imageFile}' ?? '',
                      //   imageBuilder: (context, imageProvider) => Container(
                      //     decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //         image: imageProvider,
                      //         fit: BoxFit.cover,
                      //       ),
                      //     ),
                      //   ),
                      //   placeholder: (context, url) =>
                      //       Center(child: CircularProgressIndicator()),
                      //   errorWidget: (context, url, error) => Icon(Icons.error),
                      // ),
                    ),
                  ),
                ),
              ),
              //space
              SizedBox(
                height: height * 0.03,
              ),
              //item name and price
              Container(
                  width: width * 0.92,
                  color: Colors.brown.shade300,
                  height: height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //row
                      SizedBox(
                        height: height * 0.05,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.66,
                              child: Padding(
                                padding: EdgeInsets.only(left: width * 0.05),
                                child: Text(
                                  widget.name.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.26,
                              child: Padding(
                                padding: EdgeInsets.only(left: width * 0.1),
                                child: Text(
                                  widget.price.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //text
                      SizedBox(
                        height: height * 0.05,
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.05),
                          child: Text(
                            'Taste that you Love',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )),
              //space
              SizedBox(
                height: height * 0.03,
              ),
              //row
              SizedBox(
                height: height * 0.09,
                child: Row(
                  children: [
                    //icon
                    SizedBox(
                      width: width * 0.2,
                      child: Icon(
                        size: height * 0.04,
                        Icons.lock_clock,
                        color: Colors.yellow,
                      ),
                    ),
                    //text
                    SizedBox(
                      width: width * 0.3,
                      child: Text(
                        '20-30 min',
                        style: TextStyle(
                            fontSize: height * 0.025,
                            color: Colors.white54,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //space
                    SizedBox(
                      width: width * 0.5,
                    )
                  ],
                ),
              ),
              //text
              SizedBox(
                height: height * 0.06,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.06),
                    child: Text(
                      widget.description.toString(),
                      style: TextStyle(
                          color: Colors.white, fontSize: height * 0.025),
                    ),
                  ),
                ),
              ),
              //space
              SizedBox(
                height: height * 0.20,
              ),
              //button

              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: width * 0.05),
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added To Cart')));
                    },
                    child: GestureDetector(
                      onTap: () {
                        //function
                        Provider.of<DetailScreenAddToCartBloc>(context,
                                listen: false)
                            .add(
                          DetailScreenAddToCartSuccessfullyEvent(
                            cartProductModel: (CartProductModel(
                                productId: widget.catagoryId,
                                pictureUrl: widget.image_Url,
                                productName: widget.name,
                                price: widget.price,
                                singleItemPrice: widget.price,
                                quantity: 1)),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(width * 0.02),
                        ),
                        child: Center(
                          child: Text(
                            'Add To Cart',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Padding(
              //     padding: EdgeInsets.only(right: width * 0.05),
              //     child: InkWell(
              //       onTap: () {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(content: Text('Added To Cart')));
              //       },
              //       child: GestureDetector(
              //         onTap: () {
              //           //function
              //           Provider.of<DetailScreenAddToCartBloc>(context,
              //                   listen: false)
              //               .add(
              //             DetailScreenAddToCartSuccessfullyEvent(
              //               cartProductModel: (CartProductModel(
              //                   productId: widget.catagoryId,
              //                   pictureUrl: widget.image_Url,
              //                   productName: widget.name,
              //                   price: widget.price,
              //                   singleItemPrice: widget.price,
              //                   quantity: 1)),
              //             ),
              //           );
              //         },
              //         child: Container(
              //           height: height * 0.07,
              //           width: width * 0.35,
              //           decoration: BoxDecoration(
              //             color: Colors.yellow,
              //             borderRadius: BorderRadius.circular(width * 0.02),
              //           ),
              //           child: Center(
              //             child: Text(
              //               'Add To Cart',
              //               style: TextStyle(color: Colors.black),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
/*


Container(
      height: h,
      width: w,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFF6B5E55),
        Color(0xFF5D5047),
        Color(0xFF423731),
        Color(0xFF382D27),
        Color(0xFF302720),
      ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bar Start
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                    // state.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                  color: Colors.white70,
                ),

                SizedBox(
                  width: w * 0.1,
                  child: InkWell(
                    onTap: () async {
                      List<CartProductModel> list =
                          await productDbProvider.fetchProductFromDb();
                      if (list.isEmpty) {
                        Provider.of<CartBloc>(context, listen: false)
                            .add(CartEmptyEvent());
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CartScreen();
                            },
                          ));
                        });
                      } else {
                        Provider.of<CartBloc>(context, listen: false)
                            .add(CartLoadedEvent());
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CartScreen();
                            },
                          ));
                        });
                      }
                    },
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                ),
                // IconButton(
                //   icon: const Icon(Icons.shopping_cart, color: Colors.white70),
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => CartScreen(),
                //         ));
                //   },
                // ),
              ],
            ),
          ),
          // Bar End

          //Image Start
          SizedBox(
            height: h * 0.5,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(h * 0.02),
              child: Card(
                elevation: 22,
                color: Colors.transparent,
                child: widget.image_Url == "https://food.elms.pk/"
                    ? const Center(
                        child: Text(
                          'Processing',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    : Image.network(widget.image_Url),
              ),
            ),
          ),
          //Image End

          SizedBox(
              height: h * 0.1,
              width: double.infinity,
              child: Card(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05),
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.1),
                          child: Text(
                            widget.price.toString(),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.05,
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.05),
                        child: Text(
                          'Taste that you Love',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )),
          SizedBox(
            height: h * 0.09,
            child: Row(
              children: [
                //icon
                SizedBox(
                  width: w * 0.2,
                  child: Icon(
                    size: h * 0.04,
                    Icons.lock_clock,
                    color: Colors.yellow,
                  ),
                ),
                //text
                SizedBox(
                  width: w * 0.3,
                  child: Text(
                    '20-30 min',
                    style: TextStyle(
                        fontSize: h * 0.025,
                        color: Colors.white54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                //space
                SizedBox(
                  width: w * 0.5,
                )
              ],
            ),
          ),
          SizedBox(
            height: h * 0.06,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.06),
                child: Text(
                  widget.description.toString(),
                  style: TextStyle(color: Colors.white, fontSize: h * 0.025),
                ),
              ),
            ),
          ),
          //space
          SizedBox(
            height: h * 0.20,
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: w * 0.05),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Added To Cart')));
                },
                child: GestureDetector(
                  onTap: () {
                    //function
                    Provider.of<DetailScreenAddToCartBloc>(context,
                            listen: false)
                        .add(
                      DetailScreenAddToCartSuccessfullyEvent(
                        cartProductModel: (CartProductModel(
                            productId: widget.catagoryId,
                            pictureUrl: widget.image_Url,
                            productName: widget.name,
                            price: widget.price,
                            singleItemPrice: widget.price,
                            quantity: 1)),
                      ),
                    );
                  },
                  child: Container(
                    height: h * 0.07,
                    width: w * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                    child: Center(
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );

          /********/
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: h * 0.05),
          //   child: Align(
          //     alignment: Alignment.bottomRight,
          //     child: InkWell(
          //       onTap: () {
          //         productDbProvider
          //             .insertProduct(CartProductModel(
          //                 productId: widget.catagoryId,
          //                 pictureUrl: widget.image_Url,
          //                 productName: widget.name,
          //                 price: widget.price,
          //                 singleItemPrice: widget.price,
          //                 quantity: 1))
          //             //     .insert(NotesModel(
          //             //   title: widget.name,
          //             //   quantity: 1,
          //             //   rupees: widget.price,
          //             // ))
          //             .then((value) {
          //           var snack = SnackBar(
          //               backgroundColor: Colors.grey,
          //               content: Text('Data has been Added ! Check Your Cart'));
          //           ScaffoldMessenger.of(context).showSnackBar(snack);
          //           setState(() {
          //             //notesList = helper!.getNotesList();
          //           });
          //         }).onError((error, stackTrace) {
          //           print(error.toString());
          //         });
          //       },
          //       child: Container(
          //         color: Colors.yellow,
          //         height: h * 0.05,
          //         width: w * 0.3,
          //         child: Center(
          //           child: Text('Add to Cart'),
          //         ),
          //       ),
          //     ),
          //   ),
          // )


*/