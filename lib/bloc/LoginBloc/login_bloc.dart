import 'package:bloc/bloc.dart';
import 'package:khan_foods/Models/Google_LogIn_Model.dart';
//import 'package:khan_foods/APiServices/Login_Api_Service.dart';
import 'package:khan_foods/Models/Login_Api_Model.dart';
import 'package:khan_foods/Utils/ApiServices/Api_Services.dart';
import 'package:khan_foods/Utils/Utlis/Util.dart';
import 'package:meta/meta.dart';

import '../../Models/login_model_khubaib.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    //**********Login*************

    on<LoginEventApi>((event, emit) async {
      String email = event.email;
      String password = event.password;
      emit(LoginLoadingState());
      try {
        //Map<String, dynamic> data =
        // await ApiServices.logInWithGoogleThroughApiService(
        //     event.logInWithGoogleModel);

        await Future.delayed(Duration(seconds: 5));
        emit.call(LogInSuccessfullyState(email: email));

        // if (data['Status'] == 'Login Successfully') {
        //   emit(LogInWithGoogleSuccessfullyState());
        //   print('Login Successfully');
        // } else {
        //   print('GoogleSoorry');
        // }
      } catch (e) {
        emit.call(LoginErrorState(errorOfLogInMessage: e.toString()));
      }
    });

    // **********Google**************

    on<GoogleLogInEventApi>((event, emit) async {
      String email = event.logInWithGoogleModel.toString();
      print("before loafing================");
      emit.call(LoginLoadingState());
      try {
        // Map<String, dynamic>? data =
        //     await ApiServices.logInWithGoogleThroughApiService(
        //         event.logInWithGoogleModel);
        //await ApiServices.signInWithGoogle();
        // await ApiServices.logInWithGoogleThroughApiService(
        //   event.logInWithGoogleModel);
        emit.call(LogInSuccessfullyState(email: email));
        // if (data != null) {
        //   emit.call(LogInSuccessfullyState());
        // } else {
        //   emit.call(LoginErrorState(errorOfLogInMessage: "Not Sign in"));
        // }
      } catch (e) {
        emit.call(LoginErrorState(errorOfLogInMessage: e.toString()));
      }
    });
  }
}
