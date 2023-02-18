class LogInApiModel {
  String? email;
  String? password;

  LogInApiModel({this.email, this.password});

  LogInApiModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.email;
    data['Password'] = this.password;
    return data;
  }
}