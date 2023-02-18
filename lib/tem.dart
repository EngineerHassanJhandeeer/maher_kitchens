/*
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meher_kitchen/bloc/signin_bloc/sign_in_bloc.dart';
// import 'package:meher_kitchen/screens/home_screen.dart';
// import 'package:meher_kitchen/widgets/signin_screen_widgets.dart';

// class SignInScreen extends StatelessWidget {
//   const SignInScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: Colors.brown,
//             body: BlocBuilder<SignInBloc, SignInState>(
//               builder: (context, state) {
//                 if (state is SignInInitialState) {
//                   return SignInScreenInitialUI();
//                 } else if (state is SignInSuccessfullyState) {
//                   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return HomeScreen();
//                       },
//                     ));
//                   });
//                   return SizedBox();
//                 } else if (state is SignInFailedState) {
//                   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(state.message),
//                       ),
//                     );
//                   });
//                   return SignInScreenInitialUI();
//                 } else if (state is SignInWithGoogleSuccessfullyState) {
//                   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return HomeScreen();
//                       },
//                     ));
//                   });
//                   return SizedBox();
//                 } else if (state is SignInWithGoogleFailedState) {
//                   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(state.message),
//                       ),
//                     );
//                   });
//                   return SignInScreenInitialUI();
//                 } else {
//                   return Center(
//                     child: Text('Builder Error'),
//                   );
//                 }
//               },
//             )
//             )
//             );
//   }
// }

*/
/*
class HomeScreenCategoryLoadedUI extends StatelessWidget {
  int? currentProductId;
  final List<CategoryModel> categoryList;
  ProductDbProvider productDbProvider = ProductDbProvider();

  HomeScreenCategoryLoadedUI({Key? key, required this.categoryList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;
        return Column(
          children: [
            //row...two icons
            SizedBox(
              height: height * 0.2,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  SizedBox(
                    width: width * 0.1,
                    child: InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
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
                        Icons.add_shopping_cart,
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
            //space
            SizedBox(
              height: height * 0.1,
            ),
            SizedBox(
              height: height * 0.18,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.09),
                  child: Text(
                    'Mehr Kitchen',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.07),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.12,
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.09),
                  child: Text(
                    'Better Here',
                    style: TextStyle(
                        color: Colors.white60, fontSize: height * 0.06),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: GestureDetector(
                        onTap: () {
                          currentProductId = categoryList[index].categoryId!;

                          Provider.of<HomeScreenProductBloc>(context,
                                  listen: false)
                              .add(
                                  HomeScreenCategoryFetchCategoryByIdSuccessfullyEvent(
                                      categoryId: currentProductId!));
                        },
                        child: Text(
                          categoryList[index].categoryTitle.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ));
                },
              ),
            ),
            //most popular
            SizedBox(
              height: height * 0.1,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.09),
                  child: Text(
                    'Most Popular',
                    style:
                        TextStyle(color: Colors.white, fontSize: height * 0.05),
                  ),
                ),
              ),
            ),
            //space
            SizedBox(
              height: height * 0.1,
            ),
          ],
        );
      },
    );
  }
}
*/
/*
https://food.elms.pk/swagger/index.html
*/
/*

class HomeScreenProductLoadedUI extends StatelessWidget {
  // final List<ProductListModel>? productList;
  final List<ProductByIdModel>? productListById;

  const HomeScreenProductLoadedUI({Key? key, this.productListById})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;
        return GridView.builder(
          padding: EdgeInsets.all(width * 0.05),
          itemCount: productListById!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: width * 0.02,
              crossAxisSpacing: height * 0.01,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return GestureDetector(
              //*** onTap Method of GestureDetector start ***/
                onTap: () {
                  String imageFile =
                      productListById![index].imageFile.toString();
                  double salePrice = productListById![index].salePrice!;
                  String productName =
                      productListById![index].productName.toString();
                  String description =
                      productListById![index].description.toString();
                  String productId =
                      productListById![index].productId.toString();

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return DetailScreen(
                        imageFile: imageFile,
                        salePrice: salePrice,
                        productName: productName,
                        description: description,
                        productId: productId,
                      );
                    },
                  ));
                },
                //*** End of GestureDetector Method ***/
                //
                //*** Child of GestureDetector ***/
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.brown.shade900,
                      borderRadius: BorderRadius.circular(width * 0.03)),
                  height: height,
                  child: LayoutBuilder(
                    builder: (p0, p1) {
                      double height = p1.maxHeight;
                      return Column(
                        children: [
                          SizedBox(
                            height: height * 0.05,
                          ),
                          SizedBox(
                            height: height * 0.5,
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://food.elms.pk${productListById![index].imageFile!}' ??
                                      '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            // Image.network(productList[index].imageFile!),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          //**Start Product Name */
                          SizedBox(
                            height: height * 0.12,
                            child: Text(
                              productListById![index].productName.toString(),
                              style: TextStyle(
                                  fontSize: height * 0.09, color: Colors.white
                                  ),
                            ),
                          ),
                          //** End Product Name */
                          SizedBox(
                            height: height * 0.20,
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
                                      width: p1.maxWidth * 0.3,
                                      child: Text(
                                        productListById![index]
                                            .salePrice
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: p1.maxHeight * 0.08
                                          ),
                                      )
                                      ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.1,
                          ),
                        ],
                      );
                    },
                  ),
                ));
          },
        );
      },
    );
  }
}

*/
/*
 class ProductService {
  String base_url =
      'https://food.elms.pk/api/FoodProduct/PublicGetProductListByCategoryId?CategoryId=';
      
  // String base_url = 'https://food.elms.pk/api/FoodProduct/PublicGetProductList?CategoryId=';
  // 'https://food.elms.pk/api/FoodDelivery/PublicGetListCategory';

  Future<List<ProductModel>> getProductlist(String? id_url) async {
    if (id_url != null) {
      Response response = await get(Uri.parse(base_url + id_url));

      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        var data = list.map((e) => ProductModel.fromJson(e)).toList();

        return data;
      }
      return [];
    } else {
      Response response = await get(Uri.parse(base_url + "2021"));
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        var data = list.map((e) => ProductModel.fromJson(e)).toList();

        return data;
      }
      return [];
    }
  }
}
 */
/*
class ProductService {
  String base_url =
      'https://food.elms.pk/api/FoodProduct/PublicGetProductListByCategoryId?CategoryId=';

  // String base_url = 'https://food.elms.pk/api/FoodProduct/PublicGetProductList?CategoryId=';
  // 'https://food.elms.pk/api/FoodDelivery/PublicGetListCategory';

  Future<List<ProductModel>> getProductlist(String? id_url) async {
    if (id_url != null) {
      Response response = await get(Uri.parse(base_url + id_url));

      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        var data = list.map((e) => ProductModel.fromJson(e)).toList();

        return data;
      }
      return [];
    } else {
      Response response = await get(Uri.parse(base_url + "2021"));
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        var data = list.map((e) => ProductModel.fromJson(e)).toList();

        return data;
      }
      return [];
    }
  }
}
*/
/*
import 'package:meher_kitchen/utils/local_database/product_db_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/cart_product_model.dart';

class ProductDbProvider {
  Future<bool> insertProduct(CartProductModel model) async {
    Database? database = await DbHelper.database();
    int rows =
        await database!.insert(CartProductModel.tableName, model.toMap());
    if (rows < 0) {
      return false;
    }
    return true;
  }

  Future<bool> updateProduct(CartProductModel model) async {
    Database? database = await DbHelper.database();
    int rows = await database!.update(
        CartProductModel.tableName,
        {
          CartProductModel.columnQuantity: model.quantity,
          CartProductModel.columnPrice: model.price
        },
        where: '${CartProductModel.columnProductId} = ? ',
        whereArgs: [model.productId]);
    if (rows > 0) {
      return true;
    }
    return false;
  }

  Future<bool> deleteProduct(CartProductModel model) async {
    Database? database = await DbHelper.database();
    int rows = await database!.delete(CartProductModel.tableName,
        where: '${CartProductModel.columnProductId}= ?',
        whereArgs: [model.productId]);
    if (rows > 0) {
      return true;
    }
    return false;
  }

  Future<bool> deleteAllProducts() async {
    Database? database = await DbHelper.database();
    int rows = await database!.delete('productTable');
    if (rows > 0) {
      return true;
    }
    return false;
  }

  Future<List<CartProductModel>> fetchProductFromDb() async {
    Database? database = await DbHelper.database();
    List list = await database!.query(CartProductModel.tableName);
    return list.map((e) => CartProductModel.fromMap(e)).toList();
  }
}
*/
/*
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/cart_product_model.dart';

class DbHelper {
  static Database? _db;
  static const String databaseName = 'product.db';
  static const int version = 1;

  static Future<Database?> database() async {
    if (_db != null) {
      return _db;
    }
    return _db = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: _onCreate,
    );
  }
}

void _onCreate(Database db, int version) async {
  await db.execute(CartProductModel.createTable);
}
*/
/*
I/flutter (30674): Try Position:Latitude: 29.3829892, Longitude: 71.7154897
************
******************PlaceMark*******************

I/flutter (30674): Try placeMarks:[      Name: Plot 760 C,
I/flutter (30674):       Street: Plot 760 C,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name: 762 C block,
I/flutter (30674):       Street: 762 C block,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name: Plot 762 C,
I/flutter (30674):       Street: Plot 762 C,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,

*******
*************Name*************************
I/flutter (30674): Try Name placeMarks.Name:[      Name: Plot 760 C,
I/flutter (30674):       Street: Plot 760 C,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name: 762 C block,
I/flutter (30674):       Street: 762 C block,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name: Plot 762 C,
I/flutter (30674):       Street: Plot 762 C,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,

***************
**************AdministrativeArea*********************
I/flutter (30674): Try ARea  placeMarks.administrativeArea:[      Name: Plot 760 C,
I/flutter (30674):       Street: Plot 760 C,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name: 762 C block,
I/flutter (30674):       Street: 762 C block,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name: Plot 762 C,
I/flutter (30674):       Street: Plot 762 C,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name: St

************
*******************SubThroughFare************
I/flutter (30674): Try Street  placeMarks[i].subThoroughfare;:[      Name: Plot 760 C,
I/flutter (30674):       Street: Plot 760 C,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name: 762 C block,
I/flutter (30674):       Street: 762 C block,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name: Plot 762 C,
I/flutter (30674):       Street: Plot 762 C,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name:
********
******************Country***********************
I/flutter (30674): Try  Country placeMarks[i].country;:[      Name: Plot 760 C,
I/flutter (30674):       Street: Plot 760 C,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name: 762 C block,
I/flutter (30674):       Street: 762 C block,
I/flutter (30674):       ISO Country Code: PK,
I/flutter (30674):       Country: Pakistan,
I/flutter (30674):       Postal code: 63100,
I/flutter (30674):       Administrative area: Punjab,
I/flutter (30674):       Subadministrative area: Bahawalpur,
I/flutter (30674):       Locality: Bahawalpur,
I/flutter (30674):       Sublocality: Satellite Town,
I/flutter (30674):       Thoroughfare: ,
I/flutter (30674):       Subthoroughfare: ,       Name: Plot 762 C,







PS C:\food_app\mehrs_kitchen> flutter clean
Deleting .dart_tool...                                              21ms
Deleting flutter_export_environment.sh...                            1ms
Deleting ephemeral...                                                2ms
Deleting ephemeral...                                                2ms
Deleting .flutter-plugins-dependencies...                            1ms
Deleting .flutter-plugins...                                         2ms
PS C:\food_app\mehrs_kitchen> flutter run
Running "flutter pub get" in mehrs_kitchen...                       6.0s
Building with plugins requires symlink support.

Please enable Developer Mode in your system settings. Run
  start ms-settings:developers
to open settings.
PS C:\food_app\mehrs_kitchen> flutter run
Multiple devices found:
Windows (desktop) • windows • windows-x64    • Microsoft Windows [Version 10.0.19045.2604]
Chrome (web)      • chrome  • web-javascript • Google Chrome 109.0.5414.121
Edge (web)        • edge    • web-javascript • Microsoft Edge 110.0.1587.46
[1]: Windows (windows)
[2]: Chrome (chrome)
[3]: Edge (edge)
Please choose one (To quit, press "q/Q"): q

PS C:\food_app\mehrs_kitchen> flutter upgrade

*/