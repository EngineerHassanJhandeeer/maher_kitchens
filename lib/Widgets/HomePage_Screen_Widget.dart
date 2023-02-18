import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khan_foods/Models/CartProduct_Model.dart';
import 'package:khan_foods/Models/Catgory_Model.dart';
import 'package:khan_foods/Models/Product_By_Id_Model.dart';
import 'package:khan_foods/Models/Product_List_Model.dart';
import 'package:khan_foods/Models/Product_Model.dart';
import 'package:khan_foods/Screens/Cart_Screen.dart';
import 'package:khan_foods/Screens/Detail_Screen.dart';
import 'package:khan_foods/Utils/Api_URL/Api_URL.dart';
import 'package:khan_foods/Utils/Local_Database/DbProvider.dart';
import 'package:khan_foods/Widgets/Detail_Screen_Widget.dart';
import 'package:khan_foods/bloc/Cart_Bloc/cart_bloc.dart';
import 'package:khan_foods/bloc/Home_Screen_Bloc/Home_Screen_Product_bloc/bloc/home_screen_product_bloc.dart';

import 'package:khan_foods/bloc/ProductList_Bloc/product_list_bloc.dart';

import 'package:provider/provider.dart';

class HomeScreenLoadingUI extends StatelessWidget {
  const HomeScreenLoadingUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class HomeScreenCategoryLoadedUI extends StatelessWidget {
  int? currentProductId;
  final List<CategoryModel> list;
  ProductDbProvider productDbProvider = ProductDbProvider();
  HomeScreenCategoryLoadedUI({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double height = constraints.maxHeight;
      double width = constraints.maxWidth;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon Row SizeBox
          SizedBox(
            height: height * 0.2,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                // Icon of menu
                SizedBox(
                  width: width * 0.1,
                  child: InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.7,
                ),
                // Icon of Cart
//////////////////////////////////////////////////////////////////////
                // SizedBox(
                //   width: width * 0.1,
                //   child: InkWell(
                //     onTap: () async {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => CartScreen(),
                //           ));
                //     },
                //     child: Icon(
                //       Icons.shopping_cart,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
/////////////////////////////////////////////////////////////////
                // IconButton(
                //   icon: Icon(Icons.shopping_cart, color: Colors.white70),
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => CartScreen(),
                //         ));
                //   },
                // ),
//////////////////////////////////////////////////////
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
          //App Name SizeBox
          SizedBox(
            height: height * 0.18,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.09),
                child: Text(
                  'Khan Foods',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.07),
                ),
              ),
            ),
          ),
          //Better Taste SizeBox
          SizedBox(
            height: height * 0.2,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.09),
                child: Text(
                  'Better Taste',
                  style:
                      TextStyle(color: Colors.white60, fontSize: height * 0.06),
                ),
              ),
            ),
          ),
          // For List SizeBox
          SizedBox(
            height: height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: width / 2,
                  child: InkWell(
                    onTap: () {
                      int idnum = list[index].categoryId!;
                      print(idnum);
                      Provider.of<HomeScreenProductBloc>(context, listen: false)
                          .add(
                              HomeScreenCategoryFetchCategoryByIdSuccessfullyEvent(
                                  categoryId: idnum));
                      // Provider.of<ProductListBloc>(context, listen: false)
                      //     .add(ProductItemListEvent(
                      //   idNumber: idnum.toString(),
                      // ));
                    },
                    child: Card(
                      color: Colors.transparent,
                      child: Center(
                          child: Text(
                        list[index].categoryTitle.toString(),
                        style: const TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                );
              },
            ),

            // ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: list.length,
            //   itemBuilder: (context, index) {
            //     return Padding(
            //         padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            //         child: GestureDetector(
            //           onTap: () {
            //             int? idNum = list[index].categoryId;
            //             currentProductId = list[index].categoryId!;

            //             Provider.of<ProductListBloc>(context, listen: false)
            //                 .add(ProductItemListEvent(
            //                     idNumber: idNum.toString()));
            //           },
            //           child: Text(
            //             list[index].categoryId.toString(),
            //             style: TextStyle(color: Colors.white),
            //           ),
            //         ));
            //   },
            // ),
          ),
          // MostPapular SizeBox
          SizedBox(
            height: height * 0.1,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.03),
                child: Text(
                  'Most Popular',
                  style:
                      TextStyle(color: Colors.white, fontSize: height * 0.06),
                ),
              ),
            ),
          ),
          //space
          //   SizedBox(
          //     height: height * 0.1,
          //   ),
        ],
      );
    });
  }
}

//******Product ListUI */

class HomeScreenProductLoadedUI extends StatelessWidget {
  final List<ProductByIdModel> list;

  HomeScreenProductLoadedUI({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;
        return GridView.builder(
            //padding: EdgeInsets.all(width * 0.05),
            itemCount: list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: height * 0.01,
                crossAxisSpacing: height * 0.01,
                crossAxisCount: 2),
            itemBuilder: ((context, index) {
              String urlOfImage = list[index].imageFile.toString();
              String title_Of_Item = list[index].productName.toString();
              double? rupees = list[index].salePrice;
              //String apiImageFile = productListById![index].imageFile.toString();
              print('********Screen***Wigdet****');
              print(urlOfImage);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          image_Url: 'https://food.elms.pk/' + urlOfImage,
                          // list[index].image.toString(),
                          name: title_Of_Item,
                          price: rupees,
                          productId: list[index].productId,
                          catagoryId: list[index].categoryId.toString(),
                          description: list[index].description,
                        ),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: NetworkImage(apiImageFile),
                      //   fit: BoxFit.cover,
                      // ),
                      color: Colors.brown.shade900,
                      borderRadius: BorderRadius.circular(width * 0.03)),
                  height: height,
                  child: LayoutBuilder(builder: ((p0, p1) {
                    double height = p1.maxHeight;
                    double width = p1.maxWidth;
                    return SizedBox(
                      height: height * 0.99,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          SizedBox(
                            height: height * 0.52,
                            width: width,
                            child: urlOfImage.isEmpty
                                ? Center(
                                    child: Image.asset('assets/image/food.gif')
                                    //   Text(
                                    //   'Processing',
                                    //   style: TextStyle(
                                    //       fontSize: 12, color: Colors.white),
                                    // )
                                    )
                                : Image.network(
                                    baseUrl + urlOfImage,
                                    //list[index].image.toString()
                                  ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          //Name
                          SizedBox(
                            height: height * 0.12,
                            child: Text(
                              list[index].productName.toString(),
                              style: TextStyle(
                                  fontSize: height * 0.09, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.23,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //** Price Title */
                                  SizedBox(
                                      width: p1.maxWidth * 0.2,
                                      child: Text(
                                        'UED',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: p1.maxHeight * 0.08),
                                      )),
                                  //***Price */
                                  SizedBox(
                                      width: p1.maxWidth * 0.25,
                                      child: Text(
                                        list[index].salePrice.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: p1.maxHeight * 0.08),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.1,
                          ),
                        ],
                      ),
                    );
                  })),
                ),
              );
            }));
      }),
    );
  }
}

class HomeScreenProductNotAvailabelProductUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double height = constraints.maxHeight;
      double width = constraints.maxWidth;
      return GridView.builder(

          //padding: EdgeInsets.all(width * 0.05),
          itemCount: 30,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: height * 0.01,
              crossAxisSpacing: height * 0.01,
              crossAxisCount: 2),
          itemBuilder: ((context, index) {
            return Container(
              color: Colors.green,
              child: SizedBox(
                  height: height * 0.52,
                  width: width,
                  child: Center(
                    child: Image.asset('assets/image/food.gif'),
                  )),
            );
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => DetailScreen(
            //             image_Url: 'https://food.elms.pk/' + urlOfImage,
            //             // list[index].image.toString(),
            //             name: title_Of_Item,
            //             price: rupees,
            //             productId: list[index].productId,
            //             catagoryId: list[index].categoryId.toString(),
            //             description: list[index].description,
            //           ),
            //         ));
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //         // image: DecorationImage(
            //         //   image: NetworkImage(apiImageFile),
            //         //   fit: BoxFit.cover,
            //         // ),
            //         color: Colors.brown.shade900,
            //         borderRadius: BorderRadius.circular(width * 0.03)),
            //     height: height,
            //     child: LayoutBuilder(builder: ((p0, p1) {
            //       double height = p1.maxHeight;
            //       double width = p1.maxWidth;
            //       return SizedBox(
            //         height: height * 0.99,
            //         child: Column(
            //           children: [
            //             SizedBox(
            //               height: height * 0.02,
            //             ),
            //             SizedBox(
            //               height: height * 0.52,
            //               width: width,
            //               child: urlOfImage.isEmpty
            //                   ? Center(
            //                       child: Image.asset('assets/image/food.gif')
            //                       //   Text(
            //                       //   'Processing',
            //                       //   style: TextStyle(
            //                       //       fontSize: 12, color: Colors.white),
            //                       // )
            //                       )
            //                   : Image.network(
            //                       baseUrl + urlOfImage,
            //                       //list[index].image.toString()
            //                     ),
            //             ),
            //             SizedBox(
            //               height: height * 0.01,
            //             ),
            //             //Name
            //             SizedBox(
            //               height: height * 0.12,
            //               child: Text(
            //                 list[index].productName.toString(),
            //                 style: TextStyle(
            //                     fontSize: height * 0.09, color: Colors.white),
            //               ),
            //             ),
            //             SizedBox(
            //               height: height * 0.23,
            //               child: Padding(
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: width * 0.03),
            //                 child: Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     //** Price Title */
            //                     SizedBox(
            //                         width: p1.maxWidth * 0.2,
            //                         child: Text(
            //                           'UED',
            //                           style: TextStyle(
            //                               color: Colors.white,
            //                               fontSize: p1.maxHeight * 0.08),
            //                         )),
            //                     //***Price */
            //                     SizedBox(
            //                         width: p1.maxWidth * 0.25,
            //                         child: Text(
            //                           list[index].salePrice.toString(),
            //                           style: TextStyle(
            //                               color: Colors.white,
            //                               fontSize: p1.maxHeight * 0.08),
            //                         )),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               height: height * 0.1,
            //             ),
            //           ],
            //         ),
            //       );
            //     })),
            //   ),
            // );
          }));
    });
    // Container(
    //   color: Colors.brown.shade900,
    //   child: Center(
    //     child: Text(
    //       'Sorry Not Availabel this Time',
    //       style: TextStyle(color: Colors.white, fontSize: height * 0.02),
    //     ),
    //   ),
    // );
  }
}
