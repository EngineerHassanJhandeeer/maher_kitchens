import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:geocoding/geocoding.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:khan_foods/Models/Conform_Order_Model.dart';
import 'package:khan_foods/Models/Google_LogIn_Model.dart';
import 'package:khan_foods/Models/Login_Api_Model.dart';
import 'package:khan_foods/Models/Proced_To_Checkout_Model.dart';
import 'package:khan_foods/Models/Product_By_Id_Model.dart';
import 'package:khan_foods/Models/Product_List_Model.dart';
import 'package:khan_foods/Models/Product_Model.dart';
import 'package:khan_foods/Models/Sign_Up_API_Model.dart';
import 'package:khan_foods/Utils/Api_URL/Api_URL.dart';
import 'package:khan_foods/Utils/Utlis/Util.dart';

import '../../Models/Catgory_Model.dart';
//import 'package:khan_foods/Utlis/Util.dart';

class ApiServices {
  //*** 1
  //****************SIGNUP METHOD**************
  static Future<Map<String, dynamic>> signUpPost(
      SignUpApiModel signUpDataApiSerice) async {
    Response response = await post(Uri.parse(baseUrl + signUpUserUrl),
        body: jsonEncode({
          'email': signUpDataApiSerice.email,
          'password': signUpDataApiSerice.password,
          'displayName': signUpDataApiSerice.displayName,
          'loginby': signUpDataApiSerice.loginBy,
        }),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    final stringResponseCode = response.body;
    Map<String, dynamic> data = jsonDecode(stringResponseCode);
    return data;
    //
    //
    //
    //Utils().toastMessage('Response: ${response.statusCode}');
    //
    // if (response.statusCode == 200) {
    //   // Utils()
    //   //     .toastMessage('Acount created successfully: ${response.statusCode}');
    //   var data = jsonEncode(response.body.toString());

    //   print(response.statusCode);
    //   print('Acount created successfully');
    //   //10267491

    //   //print(data['token']);
    // } else {
    //   //Utils().toastMessage('Sorry SignUp failed: ${response.statusCode}');
    //   print(response.statusCode);
    //   print('Sorry SignUp failed');
    // }
  }

  //****** 2
  //****************CHECK EMAIL METHOD**************
  static Future<Map<String, dynamic>> checkEmail(
      SignUpApiModel signUpEmailCheck) async {
    Response response = await post(Uri.parse(baseUrl + checkEmailUrl),
        body: jsonEncode({'email': signUpEmailCheck.email}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

  //**** 3
  //*****************LOGIN METHOD**************
  static Future<Map<String, dynamic>?> logInMethod(
      String email, String password) async {
    String login_url = 'https://food.elms.pk/api/FoodDelivery/PublicCheckLogin';
    var data = {
      'Email': email.toString(),
      'Password': password.toString(),
    };
    var body = jsonEncode(data);
    var headers = {'Content-Type': 'application/json'};
    Response response =
        await post(Uri.parse(login_url), headers: headers, body: body);

    if (response.statusCode == 200) {
      var newdata = jsonDecode(response.body);
      return newdata;
    }
    return null;
  }

  //******** 4
  //****************LOGINWITH GOOGLE METHOD**************
  static Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    //    UserCredential userCredential =
    //     await FirebaseAuth.instance.signInWithCredential(credential);
    // return userCredential.user;
  }

  static Future<Map<String, dynamic>?> logInWithGoogleThroughApiService(
      LogInWithGoogleModel logInWithGoogleModel) async {
    User? user = await signInWithGoogle();
    if (user != null) {
      String? email = user.email;
      var data = {'email': email, 'loginBy': logInWithGoogleModel.loginBy};
      var body = jsonEncode(data);
      Response response = await post(Uri.parse(baseUrl + googleSignInUrl),
          body: body,
          //jsonEncode(
          // {'email': email, 'loginBy': logInWithGoogleModel.loginBy},
          //),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      print(response.body);

      final stringResponseCode = response.body;
      Map<String, dynamic> newData = jsonDecode(stringResponseCode);
      return newData;
    }
    return null;
  }

  //**********GetProductItemList
  // HomeScreen Vertical List Show Method
  // static String base_url =
  //   'https://food.elms.pk/api/FoodProduct/PublicGetProductListByCategoryId?CategoryId=';
  // String base_url = 'https://food.elms.pk/api/FoodProduct/PublicGetProductList?CategoryId=';
  // 'https://food.elms.pk/api/FoodDelivery/PublicGetListCategory';

//////***************************************************** */

  static Future<List<CategoryModel>> getCategoryList() async {
    Response response = await get(Uri.parse(baseUrl + categoryListUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => CategoryModel.fromMap(e)).toList();
    }

    return [];
  }

  static Future<List<ProductByIdModel>> getProductList() async {
    Response response = await get(Uri.parse(baseUrl + productListUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => ProductByIdModel.fromJson(e)).toList();
    }
    return [];
  }

  static Future<List<ProductByIdModel>> getProductById(int categoryId) async {
    Response response =
        await get(Uri.parse('$baseUrl$productByIdUrl?CategoryId=$categoryId'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((e) => ProductByIdModel.fromJson(e)).toList();
    }
    return [];
  }

  // static Future<List<ProductModel>> getProductItemList(String? id_Url) async {
  //   if (id_Url != null) {
  //     Response response = await get(Uri.parse(base_url + id_Url));
  //     if (response.statusCode == 200) {
  //       List list = jsonDecode(response.body);
  //       print(' IF GetProductItemList List: ${list}');
  //       var data = list.map((e) => ProductModel.fromJson(e)).toList();
  //       print('IF  GetProductItemList Data: ${data}');
  //       return data;
  //     }
  //     return [];
  //   } else {
  //     Response response = await get(Uri.parse(base_url + "2021"));
  //     if (response.statusCode == 200) {
  //       List list = jsonDecode(response.body);
  //       print(' ELSE GetProductItemList List: ${list}');
  //       var data = list.map((e) => ProductModel.fromJson(e)).toList();
  //       print('ELSE  GetProductItemList Data: ${data}');
  //       return data;
  //     }
  //     return [];
  //   }
  // }

  // static Future<List<ProductModel>> getProductItemlist(String? id_url) async {
  //   if (id_url != null) {
  //     Response response = await get(Uri.parse(base_url + id_url));

  //     if (response.statusCode == 200) {
  //       List list = jsonDecode(response.body);
  //       var data = list.map((e) => ProductModel.fromJson(e)).toList();

  //       return data;
  //     }
  //     return [];
  //   } else {
  //     Response response = await get(Uri.parse(base_url + "2021"));
  //     if (response.statusCode == 200) {
  //       List list = jsonDecode(response.body);
  //       var data = list.map((e) => ProductModel.fromJson(e)).toList();

  //       return data;
  //     }
  //     return [];
  //   }
  // }

  //**********GetProductList
  // HomeScreen Horzental List Show Method

  // static Future<List<ProductListModel>> getProductList() async {
  //   String base_Url =
  //       'https://food.elms.pk/api/FoodDelivery/PublicGetListCategory';
  //   Response response = await http.get(Uri.parse(base_Url));
  //   if (response.statusCode == 200) {
  //     List data = jsonDecode(response.body);
  //     print(' GetProductList Data: ${data}');
  //     var list = data
  //         .map<ProductListModel>((e) => ProductListModel.fromJson(e))
  //         .toList();
  //     print(' GetProductList List: ${list}');
  //     return list;
  //   }
  //   return [];
  // }

  // static Future<List<ProductListModel>> getProductlist() async {
  //   String base_Url =
  //       'https://food.elms.pk/api/FoodDelivery/PublicGetListCategory';
  //   Response response = await http.get(Uri.parse(base_Url));
  //   if (response.statusCode == 200) {
  //     print(response.body.toString());
  //     List data = jsonDecode(response.body);
  //     var list = data
  //         .map<ProductListModel>((e) => ProductListModel.fromJson(e))
  //         .toList();

  //     return list;
  //   }
  //   return [];
  // }

  // Future<Map<String, dynamic>> proceedToCheckOutOrder(
  //     List<ProceedToCheckOutModel> list) async {
  //   List<Map<String, dynamic>> ls = list.map((e) => e.toMap()).toList();
  //   Response response = await post(Uri.parse(baseUrl + proceedToCheckOutUrl),
  //       body: jsonEncode(ls),
  //       headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  //   Map<String, dynamic> data = jsonDecode(response.body);
  //   return data;
  // }

  static Future<Map<String, dynamic>> proceedToCheckOutOrder(
      List<ProceedToCheckOutModel> list) async {
    List<Map<String, dynamic>> apiList = list.map((e) => e.toMap()).toList();
    var body = jsonEncode(apiList);
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    Response response = await post(Uri.parse(baseUrl + proceedToCheckOutUrl),
        body: body, headers: headers);
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> confirmOrder(
      ConfirmOrderModel model) async {
    var apiData = {
      'ClientId': model.clientId,
      'OrderTotalAmount': model.orderTotalAmount,
      'OrderAmount': model.orderAmount,
      'TaxAmount': model.taxAmount,
      'OrderDescription': model.orderDescription,
      'DeliveryAddress': model.deliveryCharges,
      'DeliveryPhoneNumber': model.deliveryPhoneNumber,
      'TaxPercentage': model.taxPercentage,
      'DeliveryCharges': model.deliveryCharges
    };
    var body = jsonEncode(apiData);
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    Response response = await post(Uri.parse(baseUrl + confirmOrderUrl),
        body: body, headers: headers);
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

  // Future<Position> getLocation() async {
  //   try {
  //     var position = await Geolocator.getCurrentPosition(
  //             desiredAccuracy: LocationAccuracy.best,
  //             timeLimit: Duration(seconds: 10))
  //         .then((value) {
  //       print(value);
  //       return value;
  //     });
  //     return position;
  //   } catch (e) {
  //     print('$e');
  //     return getLastKnownLocation();
  //   }
  // }

  // Future<String> getStringFromPlaceMarketing() async {
  //   try {
  //     await getLocation().then((value) async {
  //       var deliversTo = await placemarkFromCoordinates(
  //               position.latitude, position.longitude,
  //               localeIdentifier: 'en')
  //           .then((value) {
  //         return value.first.locality;
  //       });
  //     });
  //     return deliversTo;
  //   } catch (e) {
  //     print('$e');
  //     return null;
  //   }
  // }
//************************************************************** */
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {});
    return await Geolocator.getCurrentPosition();

    // await Geolocator.requestPermission()
    //     .then((value) {})
    //     .onError((error, stackTrace) {
    //   print('error$error');
    // });
    // return await Geolocator.getCurrentPosition();
  }
  //******************************************************************** */
}
  //****** 5

//   static Future<List<CategoryModel>?> getCategoryList() async {
//     // String base_Url =
//     //   'https://food.elms.pk/api/FoodDelivery/PublicGetListCategory';
//     Response response = await http.get(Uri.parse(baseUrl + categoryListUrl));
//     //Response response = await get(Uri.parse(base_Url));
//     if (response.statusCode == 200) {
//       List data = jsonDecode(response.body);
//       return data.map((e) => CategoryModel.fromMap(e)).toList();
//       //data.map((e) => CategoryModel.fromMap(e)).toList();
//     }

//     return [];
//   }

//   //**** 6

//   static Future<List<ProductByIdModel>> getProductList(String idNumber) async {
//     Response response = await get(Uri.parse(baseUrl + productListUrl));
//     if (response.statusCode == 200) {
//       List data = jsonDecode(response.body);
//       return data.map((e) => ProductByIdModel.fromJson(e)).toList();
//     }
//     return [];
//   }

//   //**** 7
//   static Future<List<ProductByIdModel>> getProductById(int categoryId) async {
//     Response response =
//         await get(Uri.parse('$baseUrl$productByIdUrl?CategoryId=$categoryId'));
//     if (response.statusCode == 200) {
//       List data = jsonDecode(response.body);

//       return data.map((e) => ProductByIdModel.fromJson(e)).toList();
//     }
//     return [];
//   }

//   static Future loginPost(LogInApiModel logInDataApiService) async {
//     try {
//       Response response = await post(
//         Uri.parse(baseUrl + logInUserUrl),
//         body: jsonEncode(
//           {
//             'email': logInDataApiService.email,
//             'password': logInDataApiService.password,
//           },
//         ),
//         headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//         // headers: {
//         //   HttpHeaders.contentTypeHeader:""
//         // }
//       );
//       Map<String, dynamic> data = jsonDecode(response.body);
//       return data;
//       Utils().toastMessage('Response: ${response.statusCode}');
//       if (response.statusCode == 200) {
//         Utils().toastMessage('Login  successfully: ${response.statusCode}');
//         var data = jsonEncode(response.body.toString());
//         print(response.statusCode);
//         print('Login successfully');
//       } else {
//         Utils().toastMessage('Sorry  Loginfailed: ${response.statusCode}');
//         print(response.statusCode);
//         print('Login failed');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   static Future<User?> signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;

//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );

//     // Once signed in, return the UserCredential
//     await FirebaseAuth.instance.signInWithCredential(credential);

//     //    UserCredential userCredential =
//     //     await FirebaseAuth.instance.signInWithCredential(credential);
//     // return userCredential.user;
//   }

//   static Future<Map<String, dynamic>?> logInWithGoogleThroughApiService(
//       LogInWithGoogleModel logInWithGoogleModel) async {
//     User? user = await signInWithGoogle();
//     if (user != null) {
//       String? email = user.email;

//       Response response = await post(Uri.parse(baseUrl + googleSignInUrl),
//           body: jsonEncode(
//             {'email': email, 'loginBy': logInWithGoogleModel.loginBy},
//           ),
//           headers: {HttpHeaders.contentTypeHeader: 'application/json'});
//       print(response.body);

//       final stringResponseCode = response.body;
//       Map<String, dynamic> data = jsonDecode(stringResponseCode);
//       return data;
//     }
//     return null;
//   }

//   //static Future<Map<String, dynamic>> googleLogInWithApi(LogInWithGoogleModel logInWithGoogleModel)async{}

//   //import 'package:google_sign_in/google_sign_in.dart';

// }


