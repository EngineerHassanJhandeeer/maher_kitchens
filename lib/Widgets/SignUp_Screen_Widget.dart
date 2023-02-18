import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:khan_foods/Custom_Button/My_Custom_Button.dart';
import 'package:khan_foods/Models/Sign_Up_API_Model.dart';
import 'package:khan_foods/Screens/LogIn_Screen.dart';
import 'package:khan_foods/Widgets/Login_Screen_Widget.dart';
import 'package:khan_foods/Widgets/login_Page_Widget.dart';
import 'package:khan_foods/bloc/SignUpBloc/sign_up_bloc.dart';
import 'package:provider/provider.dart';

class SignUppageWidget extends StatefulWidget {
  const SignUppageWidget({Key? key}) : super(key: key);

  @override
  State<SignUppageWidget> createState() => SignUppageWidgetState();
}

class SignUppageWidgetState extends State<SignUppageWidget> {
  TextEditingController firstNameCotroller = TextEditingController();
  TextEditingController lastNameCotroller = TextEditingController();
  TextEditingController emailCotroller = TextEditingController();
  TextEditingController passwordCotroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var signUp_Bloc = Provider.of<SignUpBloc>(context, listen: false);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double mini = min(h, w);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(mini * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: h * 0.1,
            ),
            SizedBox(
              height: h * 0.1,
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
            TextFormField(
              validator: RequiredValidator(errorText: ' *required'),
              decoration: const InputDecoration(
                hintText: 'Enter first name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              controller: firstNameCotroller,
            ),
            SizedBox(
              height: h * 0.005,
            ),
            TextFormField(
              validator: RequiredValidator(errorText: ' *required'),
              decoration: const InputDecoration(
                hintText: 'Enter last name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              controller: lastNameCotroller,
            ),
            SizedBox(
              height: h * 0.005,
            ),
            TextFormField(
              validator: MultiValidator([
                EmailValidator(errorText: 'enter a valid email address'),
                RequiredValidator(errorText: ' *required'),
              ]),
              decoration: const InputDecoration(
                hintText: 'Enter Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              controller: emailCotroller,
            ),
            SizedBox(
              height: h * 0.005,
            ),
            TextFormField(
              validator: RequiredValidator(errorText: ' *required'),
              decoration: const InputDecoration(
                hintText: 'Enter Password',
                prefixIcon: Icon(Icons.password),
                border: OutlineInputBorder(),
              ),
              controller: passwordCotroller,
            ),
            SizedBox(
              height: h * 0.1,
            ),
            RoundButton(
              title: ' LOGIN ',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  signUp_Bloc.add(SignUpEventApi(
                      signUpDataEvent: SignUpApiModel(
                          email: emailCotroller.text.toString(),
                          password: passwordCotroller.text.toString(),
                          displayName: firstNameCotroller.text.toString() +
                              lastNameCotroller.text.toString(),
                          loginBy: '1')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*
email: emailCotroller.text.toString(),
              password: passwordCotroller.text.toString(),
              displayName: firstNameCotroller.text.toString() +
                  lastNameCotroller.text.toString(),
              loginBy: '1'));
*/
 /*
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInPageScreen()));
                          */