import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khan_foods/Screens/LogIn_Screen.dart';
import 'package:khan_foods/Widgets/HomePage_Screen_Widget.dart';
import 'package:khan_foods/Widgets/Login_Screen_Widget.dart';
import 'package:khan_foods/Widgets/SignUp_Screen_Widget.dart';
import 'package:khan_foods/Widgets/login_Page_Widget.dart';
import 'package:khan_foods/bloc/LoginBloc/login_bloc.dart';
import 'package:khan_foods/bloc/SignUpBloc/sign_up_bloc.dart';
import 'package:provider/provider.dart';

class SignUpPageScreen extends StatefulWidget {
  const SignUpPageScreen({Key? key}) : super(key: key);

  @override
  State<SignUpPageScreen> createState() => SignUpPageScreenState();
}

class SignUpPageScreenState extends State<SignUpPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Center(child:
          BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
        if (state is SignUpInitialState) {
          return SignUppageWidget();
        } else if (state is SignUpSuccessfullyState) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LogInPageScreen();
            }));
          });
          return SizedBox();
        } else if (state is SignUpErrorState) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          });
          return SignUppageWidget();
        } else {
          return SizedBox(
            child: Text('Builder Error'),
          );
        }
      })),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //signUp_Bloc.add(SignUpEventApi(email: email, password: password, displayName: displayName, loginBy: loginBy));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/
    );
  }
}
