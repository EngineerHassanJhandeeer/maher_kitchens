import 'dart:math';

//import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:khan_foods/Custom_Button/My_Custom_Button.dart';
import 'package:khan_foods/Models/Google_LogIn_Model.dart';
import 'package:khan_foods/Screens/SignUp_Screen.dart';

//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

import 'package:khan_foods/bloc/LoginBloc/login_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageWidget extends StatelessWidget {
  LoginPageWidget({
    super.key,
  });
  TextEditingController emailCotroller = TextEditingController();
  TextEditingController passwordCotroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var logIn_Bloc = Provider.of<LoginBloc>(context, listen: false);

    var size = MediaQuery.of(context).size;
    double h = size.height - 85;
    double w = size.width;
    double mini = min(h, w);

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.1,
            ),
            //
            Card(
              color: Colors.green,
              child: Center(
                child: Text(
                  'KHAN FOODS',
                  style: TextStyle(
                      color: Colors.yellow.shade400,
                      fontSize: mini * 0.09,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //
            SizedBox(
              height: h * 0.03,
            ),
            //
            TextFormField(
              validator: MultiValidator([
                EmailValidator(errorText: 'enter a valid email address'),
                RequiredValidator(errorText: ' *required'),
              ]),
              //
              decoration: const InputDecoration(
                hintText: 'Enter Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              controller: emailCotroller,
            ),

            SizedBox(
              height: h * 0.03,
            ),

            // Second TextFormField

            TextFormField(
              maxLength: 6,
              validator: RequiredValidator(errorText: ' *required'),
              obscureText: true,
              controller: passwordCotroller,
              decoration: const InputDecoration(
                hintText: 'Enter Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility_off),
                border: OutlineInputBorder(),
              ),
            ),
            //
            SizedBox(
              height: h * 0.03,
            ),
            //
            // Login Button
            RoundButton(
              title: ' LOGIN ',
              onTap: () async {
                FocusManager.instance.primaryFocus!.unfocus();
                if (formKey.currentState!.validate()) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setBool('islogin', true);
                  logIn_Bloc.add(LoginEventApi(
                      email: emailCotroller.text.toString(),
                      password: passwordCotroller.text.toString()));
                }
              },
            ),
            //

            //row
            SizedBox(
              height: h * 0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  Container(
                    height: h * 0.003,
                    width: w * 0.3,
                    color: Colors.black,
                  ),
                  //
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                      child: Text(
                        'Or',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  //
                  Container(
                    height: h * 0.003,
                    width: w * 0.3,
                    color: Colors.black,
                  )
                  //
                ],
              ),
            ),
            //
            SizedBox(
              height: h * 0.005,
            ),
            //
            // Google Button
            RoundButton(
              title: ' G ',
              onTap: () async {
                FocusManager.instance.primaryFocus!.unfocus();
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setBool('islogin', true);
                logIn_Bloc.add(
                  GoogleLogInEventApi(
                    logInWithGoogleModel: LogInWithGoogleModel(loginBy: '2'),
                  ),
                );
                /*
                      if (formKey.currentState!.validate()) {
                          logIn_Bloc.add(LoginEventApi(
                              logInDataEvent: LogInApiModel(
                                  email: emailCotroller.text.toString(),
                                  password:
                                      passwordCotroller.text.toString())));
                        }
                        googleLogIn();
                        */
              },
            ),
            //
            SizedBox(
              height: h * 0.005,
            ),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                Text("Don't have an acount? "),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SignUpPageScreen())));
                    },
                    child: Card(
                        color: Colors.deepOrangeAccent.shade200,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: mini * 0.03,
                              fontWeight: FontWeight.bold),
                        )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
