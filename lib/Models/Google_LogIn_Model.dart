class LogInWithGoogleModel {
  String? email;
  String? loginBy;

  LogInWithGoogleModel({this.email, this.loginBy});

  LogInWithGoogleModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    loginBy = json['LoginBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.email;
    data['LoginBy'] = this.loginBy;
    return data;
  }
}

/*
// class SignInWithGoogleModel {
//   String ?email;
//   int ?loginBy;
//   SignInWithGoogleModel({
//     this.email,
//     this.loginBy,
//   });
//
//   SignInWithGoogleModel.fromJson(dynamic json) {
//     email = json['Email'];
//     loginBy = json['LoginBy'];
//   }
//
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['Email'] = email;
//     map['LoginBy'] = loginBy;
//     return map;
//   }
// }
// To parse this JSON data, do
//
//     final signInWithGoogle = signInWithGoogleFromMap(jsonString);

import 'dart:convert';

class SignInWithGoogleModel {
  String? email;
  String? loginBy;
  SignInWithGoogleModel({
    this.email,
    this.loginBy,
  });

  factory SignInWithGoogleModel.fromJson(String str) =>
      SignInWithGoogleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignInWithGoogleModel.fromMap(Map<String, dynamic> json) =>
      SignInWithGoogleModel(
        email: json["Email"],
        loginBy: json["LoginBy"],
      );

  Map<String, dynamic> toMap() => {
        "Email": email,
        "LoginBy": loginBy,
      };
}
*/