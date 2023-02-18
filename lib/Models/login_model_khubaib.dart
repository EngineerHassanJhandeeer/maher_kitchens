// import 'dart:convert';

// import 'package:http/http.dart';

// Future<Map<String, dynamic>?> LoginMethod(String email, String password) async {
//   String login_url = 'https://food.elms.pk/api/FoodDelivery/PublicCheckLogin';
//   var data = {
//     'Email': email.toString(),
//     'Password': password.toString(),
//   };
//   var body = jsonEncode(data);
//   var headers = {'Content-Type': 'application/json'};
//   Response response =
//       await post(Uri.parse(login_url), headers: headers, body: body);

//   if (response.statusCode == 200) {
//     var newdata = jsonDecode(response.body);
//     return newdata;
//   }
//   return null;
// }
