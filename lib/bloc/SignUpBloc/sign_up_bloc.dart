import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
//import 'package:khan_foods/APiServices/Sign_Up_Api_Service.dart';
import 'package:khan_foods/Models/Sign_Up_API_Model.dart';
import 'package:khan_foods/Utils/ApiServices/Api_Services.dart';
import 'package:khan_foods/Utils/Utlis/Util.dart';
//import 'package:khan_foods/Utlis/Util.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpEventApi>((event, emit) async {
      emit(SignUpInitialState());
      print('error');
      try {
        var data = await ApiServices.signUpPost(
          event.signUpDataEvent,
        );
        print(data);
        emit(SignUpSuccessfullyState(apiData: data));
        //  Utils().toastMessage('Data Send: ${data}');
      } catch (e) {
        //Utils().toastMessage(e.toString());
        print(e.toString());
      }
    });
  }
}
