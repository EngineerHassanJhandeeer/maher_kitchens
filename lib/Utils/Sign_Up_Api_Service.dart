/*
Future<Map<String, dynamic>> signUpUser(SignUpUserModel model) async {
    Response response = await post(Uri.parse(baseUrl + signUpUserUrl),
        body: jsonEncode({
          'email': model.email,
          'password': model.password,
          'displayName': model.displayName,
          'loginBy': model.loginBy
        }),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    final stringResponseCode = response.body;
    Map<String, dynamic> data = jsonDecode(stringResponseCode);
    return data;
  }
*/
/*
 /* try {
     
    } catch (e) {
      Utils().toastMessage(e.toString());
      print(e.toString());
    }
    */
*/