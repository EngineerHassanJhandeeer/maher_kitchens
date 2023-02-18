import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:khan_foods/Screens/LogIn_Screen.dart';
import 'package:khan_foods/Screens/Splash_Screen.dart';
//import 'package:khan_foods/Widgets/Login_Screen_Widget.dart';
//import 'package:khan_foods/Widgets/SignUp_Screen_Widget.dart';
//import 'package:khan_foods/Widgets/login_Page_Widget.dart';
import 'package:khan_foods/bloc/Cart_Bloc/cart_bloc.dart';
import 'package:khan_foods/bloc/ConfirmOrder_Bloc/confirm_order_bloc.dart';
import 'package:khan_foods/bloc/DetailScreenAddToCartBloc/bloc/detail_screen_add_to_cart_bloc.dart';
import 'package:khan_foods/bloc/Home_Screen_Bloc/Home_Screen_Category_bloc/home_screen_category_bloc.dart';
import 'package:khan_foods/bloc/Home_Screen_Bloc/Home_Screen_Product_bloc/bloc/home_screen_product_bloc.dart';
import 'package:khan_foods/bloc/Location_Bloc/user_location_bloc.dart';
//import 'package:khan_foods/bloc/ItemList_Bloc/bloc/item_list_bloc.dart';
import 'package:khan_foods/bloc/LoginBloc/login_bloc.dart';
//import 'package:khan_foods/bloc/ProductList_Bloc/product_list_bloc.dart';
import 'package:khan_foods/bloc/SignUpBloc/sign_up_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
//void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 1 DetailBloc
        BlocProvider(
          create: (context) => DetailScreenAddToCartBloc(),
        ),
        // 2 SignUpBloc
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        // 3 LogInBloc
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        // 4 ItemList
        BlocProvider<HomeScreenCategoryBloc>(
          create: (context) => HomeScreenCategoryBloc(),
        ),
        // 5 ConformOrderBloc
        BlocProvider<ConfirmOrderBloc>(
          create: (context) => ConfirmOrderBloc(),
        ),
        // 6 ProductListBloc
        BlocProvider<HomeScreenProductBloc>(
          create: (context) => HomeScreenProductBloc(),
        ),
        // 7 CartBloc
        BlocProvider<CartBloc>(
          create: (context) {
            return CartBloc();
          },
        ),
        // 8 UserLocation
        BlocProvider<UserLocationBloc>(
          create: (context) => UserLocationBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KHAN  FOODS',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

/*

 assert(() {
                  if (widget.errorBuilder == null) {
                    // ignore: only_throw_errors, since we're just proxying the error.
                    throw error; // Ensures the error message is printed to the console.
                  }
                  return true;
                }());
              }

Exception has occurred.
SqfliteDatabaseException 
(DatabaseException(UNIQUE constraint failed: productTable.productId 
(Sqlite code 1555 SQLITE_CONSTRAINT_PRIMARYKEY), 
(OS error - 2:No such file or directory)) s
ql 'INSERT INTO productTable (productId, 
price, quantity, pictureUrl, productName, 
subTotalPrice, salesTax, deliveryCharges, 
totalPrice, singleItemPrice) VALUES 
(?, ?, ?, ?, ?, NULL, NULL, NULL, NULL, ?)'
 args [2021, 500.0, 1,
  https://food.elms.pk//Uploads/0f760569-c651-4b7a-9...,
   Briyani, 500.0])




Exception has occurred.
SqfliteDatabaseException (DatabaseException(UNIQUE constraint failed: productTable.productId (Sqlite code 1555 SQLITE_CONSTRAINT_PRIMARYKEY), 
(OS error - 2:No such file or directory)) sql 'INSERT INTO productTable (productId, price, quantity, pictureUrl, productName, subTotalPrice, salesTax, deliveryCharges, totalPrice, singleItemPrice) VALUES 
(?, ?, ?, ?, ?, NULL, NULL, NULL, NULL, ?)' args [2021, 500.0, 1, https://food.elms.pk//Uploads/0f760569-c651-4b7a-9..., Briyani, 500.0])


throw SqfliteDatabaseException(e.message!, e.details);

*/
/*  

 profile url
  https://lh3.googleusercontent.com/a/AEdFTp61aA7jGvqgFuLYNcgLecX3WXbRc028m_XzbMLY
*******
 'Content-Type': 'application/json',
 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='

 client id 
 141024957056-btoe34k0rukig34g0i17up0s13l3o3ts.apps.googleusercontent.com
 > Task :google_sign_in_android:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
*/
/*


SizedBox(
                              width: width * 0.5,
                              child: Padding(
                                padding: EdgeInsets.only(left: width * 0.02),
                                child: Padding(
                                  padding: EdgeInsets.all(height * 0.02),
                                  child: urlOfImage == "https://food.elms.pk/"
                                      ? const Center(
                                          child: Text(
                                            'Processing',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        )
                                      : Image.network(urlOfImage),
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

                                // child:
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


///////////
 SizedBox(
  height: height * 0.12,
  child: urlOfImage.isEmpty
  ? Center(
  child: Text(
  'Processing',
  style: TextStyle(
  fontSize: 12, color: Colors.white),
  ))
  : Image.network(baseUrl +
  productListById![index].imageFile.toString()),
  ),
  */
/*

Launching lib\main.dart on STK L21 in debug mode...
lib\main.dart:1
√  Built build\app\outputs\flutter-apk\app-debug.apk.
D/FlutterGeolocator(12107): Attaching Geolocator to activity
D/FlutterGeolocator(12107): Creating service.
D/FlutterGeolocator(12107): Binding to location service.
D/FlutterGeolocator(12107): Geolocator foreground service connected
D/FlutterGeolocator(12107): Initializing Geolocator services
D/FlutterGeolocator(12107): Flutter engine connected. Connected engine count 1
Connecting to VM Service at ws://127.0.0.1:57264/9SKiaOIzLQw=/ws
D/AwareBitmapCacher(12107): handleInit switch not opened pid=12107
W/Gralloc3(12107): mapper 3.x is not supported
E/        (12107): APS:IFLoad:importExternalFunctions, search function createNewHwApsUtils failed, dlsym err:undefined symbol: createNewHwApsUtils
D/        (12107): APS:importExternalFunctions OK
I/HwViewRootImpl(12107): removeInvalidNode jank list is null
I/flutter (12107): ********************
I/flutter (12107): Hassan in ItemListInitialState
I/flutter (12107): **************************************
I/flutter (12107): This is the ProductListInitilalState
I/flutter (12107): ********************
I/flutter (12107): Hassan in ItemlistLoadingState
///////////////////////////////////
I/flutter (12107):  GetProductList Data: [
  {CategoryId: 2021, CategoryTitle: Briyani, ImageFile: }, 
  {CategoryId: 4014, CategoryTitle: Briyani , ImageFile: }, 
  {CategoryId: 6018, CategoryTitle: burger, ImageFile: },
  {CategoryId: 6023, CategoryTitle: cake, ImageFile: }, 
  {CategoryId: 2020, CategoryTitle: Fast Food, ImageFile: }, 
  {CategoryId: 6015, CategoryTitle: food, ImageFile: }, 
  {CategoryId: 2023, CategoryTitle: Macaroni, ImageFile: }, 
  {CategoryId: 2022, CategoryTitle: Pasta, ImageFile: }, 
  {CategoryId: 2019, CategoryTitle: Pizza, ImageFile: }, 
  {CategoryId: 6019, CategoryTitle: pizza, ImageFile: }, 
  {CategoryId: 6020, CategoryTitle: pizza, ImageFile: }, 
  {CategoryId: 6021, CategoryTitle: pizza, ImageFile: }, 
  {CategoryId: 6022, CategoryTitle: pizza, ImageFile: }, 
  {CategoryId: 6017, CategoryTitle: pizza, ImageFile: }, 
  {CategoryId: 3014, CategoryTitle: Street Food, ImageFile: }, 
  {CategoryId: 6016, CategoryTitle: string, ImageFile: }, 
  {CategoryId: 5014, CategoryTitle: string, ImageFile: }, 
  {CategoryId: 5015, CategoryTitle: string, Imag
  //////////////////////////////////
I/flutter (12107):  GetProductList List: [
  Instance of 'ProductListModel',
 Instance of 'ProductListModel', 
 Instance of 'ProductListModel',
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel',
   Instance of 'ProductListModel', 
   Instance of 'ProductListModel',
    Instance of 'ProductListModel', 
    Instance of 'ProductListModel',
     Instance of 'ProductListModel', 
     Instance of 'ProductListModel',
      Instance of 'ProductListModel', 
      Instance of 'ProductListModel',
       Instance of 'ProductListModel', 
       Instance of 'ProductListModel', 
       Instance of 'ProductListModel', 
       Instance of 'ProductListModel', 
       Instance of 'ProductListModel'
       ]
       ///////////////////////
I/flutter (12107): ItemList Bloc [
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel', 
  Instance of 'ProductListModel'
  ]
  ////////////////////////////
I/flutter (12107):  ELSE GetProductItemList List: [
  {ProductId: 4053, ProductName: Briyani, SalePrice: 500.0, CategoryId: 2021, ImageFile: , Description: Awesome}, 
  {ProductId: 4054, ProductName: Briyani, SalePrice: 500.0, CategoryId: 2021, ImageFile: , Description: Awesome}, 
  {ProductId: 4055, ProductName: Briyani, SalePrice: 500.0, CategoryId: 2021, ImageFile: , Description: Awesome}, 
  {ProductId: 4056, ProductName: Briyani, SalePrice: 500.0, CategoryId: 2021, ImageFile: , Description: Awesome}, 
  {ProductId: 4057, ProductName: Briyani, SalePrice: 500.0, CategoryId: 2021, ImageFile: , Description: Awesome}, 
  {ProductId: 4058, ProductName: Briyani, SalePrice: 500.0, CategoryId: 2021, ImageFile: , Description: Awesome}, 
  {ProductId: 4059, ProductName: Briyani, SalePrice: 500.0, CategoryId: 2021, ImageFile: , Description: Awesome}, 
  {ProductId: 4060, ProductName: Briyani, SalePrice: 500.0, CategoryId: 2021, ImageFile: , Description: Awesome}, 
  {ProductId: 4061, ProductName: Briyani, SalePrice: 500.0, CategoryId: 2021, ImageFile: , Descri
  /////////////////////////////////////////////////////////////////////
I/HwViewRootImpl(12107): removeInvalidNode all the node in jank list is out of time
W/libEGL  (12107): EGLNativeWindowType 0x75f2f82010 disconnect failed
W/libEGL  (12107): EGLNativeWindowType 0x765f2f9d10 disconnect failed
///////////////////////////////////////////////////////////////////////
D/SharedPreferencesImpl(12107): Time required to fsync /data/user/0/com.example.khan_foods/shared_prefs/com.google.android.gms.measurement.prefs.xml: 
[<1: 0, <2: 0, <4: 0, <8: 0, <16: 0, <32: 0, <64: 0, <128: 0, <256: 1, <512: 1, <1024: 0, <2048: 0, <4096: 0, <8192: 0, <16384: 0, >=16384: 0]
Lost connection to device.

*/  
/*

CustomTextFormField(
   //  key: _phoneNumberKey,
       validatorFunction: (value) {
      if (value!.isEmpty) {
      return 'Phone Number is Must';
      } else if (value.length != 11) {
      return 'Enter a Valid Phone No';
      }
      return null;
      },
      controller: phoneNoTextEditingController,
      hintText: 'Phone Number',
      prefixIcon: Icons.call),

*/
/*
Exception has occurred.
PlatformException (PlatformException(sqlite_error,
UNIQUE constraint failed: productTable.productId 
(Sqlite code 1555 SQLITE_CONSTRAINT_PRIMARYKEY), 
(OS error - 2:No such file or directory), {arguments: 
[2021, 500.0, 1, 
https://food.elms.pk//Uploads/0f760569-c651-4b7a-9ec5-afbe6f07adcf.png,
Briyani, 500.0], sql: INSERT INTO productTable (productId, price, quantity,
pictureUrl, productName, subTotalPrice, salesTax, deliveryCharges, 
totalPrice, singleItemPrice) VALUES (?, ?, ?, ?, ?, NULL, NULL, NULL, NULL, ?)}, null))
*/
/*   

10:42:51 PM: Executing 'signingreport'...

Executing tasks: [signingreport] in project C:\food_app\mehrs_kitchen\android

Starting Gradle Daemon...
Gradle Daemon started in 6 s 894 ms

> Task :app:signingReport
Variant: debug
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
----------
Variant: release
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
----------
Variant: profile
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
----------
Variant: debugAndroidTest
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
----------

> Task :firebase_auth:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
----------

> Task :firebase_core:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
----------

> Task :fluttertoast:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
----------

> Task :google_sign_in_android:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
----------

> Task :path_provider_android:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
----------

> Task :shared_preferences_android:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
----------

> Task :sqflite:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\HASSAN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EB:85:F9:37:C5:13:00:0C:6C:9C:75:9B:91:93:85:B6
SHA1: 5C:5D:B6:FE:56:A3:87:19:48:74:22:EF:DD:63:76:9D:23:49:4F:30
SHA-256: 1A:54:F0:01:F4:52:6C:46:70:C3:53:C7:10:F4:8E:92:C2:99:FD:A7:36:18:E8:CD:C0:06:2D:5A:2D:56:4E:DF
Valid until: Monday, December 23, 2052
----------

Deprecated Gradle features were used in this build, making it incompatible with Gradle 8.0.

You can use '--warning-mode all' to show the individual deprecation warnings and determine if they come from your own scripts or plugins.

See https://docs.gradle.org/7.4/userguide/command_line_interface.html#sec:command_line_warnings

BUILD SUCCESSFUL in 1m 21s
8 actionable tasks: 8 executed

Build Analyzer results available
10:44:15 PM: Execution finished 'signingreport'.
*/