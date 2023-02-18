import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khan_foods/Screens/Home_Screen.dart';
import 'package:khan_foods/Utils/Utlis/Util.dart';
import 'package:khan_foods/Widgets/HomePage_Screen_Widget.dart';
import 'package:khan_foods/Widgets/Login_Screen_Widget.dart';
import 'package:khan_foods/Widgets/login_Page_Widget.dart';
import 'package:khan_foods/bloc/LoginBloc/login_bloc.dart';

class LogInPageScreen extends StatelessWidget {
  const LogInPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.brown,
            body: Stack(children: [
              LoginPageWidget(),
              Container(
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginInitialState) {
                      return SizedBox();
                    } else if (state is LoginLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is LogInSuccessfullyState) {
                      String userEmail = state.email;
                      SchedulerBinding.instance
                          .addPostFrameCallback((timeStamp) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HomePageScreen(
                              email: userEmail,
                            );
                          },
                        ));
                      });
                      return SizedBox();
                    } else if (state is LoginErrorState) {
                      return SizedBox();
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ])));
  }
}
