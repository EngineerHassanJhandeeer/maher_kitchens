// class SignUpModel {
//   String? email;
//   String? password;
//   String? displayName;
//   int? loginBy;

//   SignUpModel({this.email, this.password, this.displayName, this.loginBy});

//   SignUpModel.fromJson(Map<String, dynamic> json) {
//     email = json['Email'];
//     password = json['Password'];
//     displayName = json['DisplayName'];
//     loginBy = json['LoginBy'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Email'] = this.email;
//     data['Password'] = this.password;
//     data['DisplayName'] = this.displayName;
//     data['LoginBy'] = this.loginBy;
//     return data;
//   }
// }
/*
 headers: <String, String>{
        
        'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
      },
*/
/*
Password_Field_Widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_bloc/bloc/passwordfield_bloc.dart';
import 'package:provider/provider.dart';

class CustomPasswordTextField extends StatelessWidget {
  CustomPasswordTextField({
    Key? key,
    this.validator,
    this.controller,
    this.textInputType,
    this.hintText,
    this.prefixIcon,
  }) : super(key: key);
  String? Function(String?)? validator;
  TextEditingController? controller;
  TextInputType? textInputType;
  String? hintText;
  Icon? prefixIcon;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    var passwordBloc = Provider.of<PasswordFieldBloc>(context, listen: false);
    return BlocBuilder<PasswordFieldBloc, PasswordFieldState>(
      builder: (context, state) {
        if (state is PasswordVisibleState) {
          return TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: textInputType,
            obscureText: state.isObscureText,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: IconButton(
                onPressed: () {
                  if (state.isObscureText) {
                    passwordBloc.add(VisiblePasswordEvent(obscureText: false));
                  } else {
                    passwordBloc.add(VisiblePasswordEvent(obscureText: true));
                  }
                },
                icon: state.isObscureText
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
              helperText: '',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          );
        } else {
          return TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: textInputType,
            obscureText: true,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: IconButton(
                  onPressed: () {
                    passwordBloc.add(VisiblePasswordEvent(obscureText: false));
                  },
                  icon: Icon(Icons.visibility_off)),
              helperText: '',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          );
        }
      },
    );
  }
}
*/
/*
Main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_bloc/bloc/passwordfield_bloc.dart';
import 'package:password_bloc/password_field_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PasswordFieldBloc>(
          create: (context) => PasswordFieldBloc(),
        )
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              child: CustomPasswordTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password can not be Empty';
                  }
                  if (value.length < 6) {
                    return 'Password min length is 6 Chars';
                  }
                  return null;
                },
                controller: textEditingController,
                textInputType: TextInputType.emailAddress,
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/
/*
passwordField_state
part of 'passwordfield_bloc.dart';

@immutable
abstract class PasswordFieldState {}

class PasswordFieldInitialState extends PasswordFieldState {}

class PasswordVisibleState extends PasswordFieldState {
  bool isObscureText;
  PasswordVisibleState({required this.isObscureText});
}
*/
/*
passwordField_event.dart
part of 'passwordfield_bloc.dart';

@immutable
abstract class PasswordFieldEvent {}

class VisiblePasswordEvent extends PasswordFieldEvent {
  bool obscureText;
  VisiblePasswordEvent({required this.obscureText});
}
*/
/*
passwordfield_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'passwordfield_event.dart';
part 'passwordfield_state.dart';

class PasswordFieldBloc extends Bloc<PasswordFieldEvent, PasswordFieldState> {
  PasswordFieldBloc() : super(PasswordFieldInitialState()) {
    on<VisiblePasswordEvent>((event, emit) {
      emit.call(PasswordVisibleState(isObscureText: event.obscureText));
    });
  }
}
*/