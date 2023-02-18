// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:form_field_validator/form_field_validator.dart';

// import 'package:khan_foods/Custom_Button/My_Custom_Button.dart';
// import 'package:khan_foods/Models/Google_LogIn_Model.dart';
// import 'package:khan_foods/Models/Login_Api_Model.dart';
// import 'package:khan_foods/Screens/SignUp_Screen.dart';
// import 'package:khan_foods/Screens/SignUp_Screen.dart';
// import 'package:khan_foods/Widgets/Home_Screen_Widget.dart';
// import 'package:khan_foods/Widgets/SignUp_Screen_Widget.dart';
// import 'package:khan_foods/bloc/LoginBloc/login_bloc.dart';
// import 'package:khan_foods/bloc/SignUpBloc/sign_up_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class LoginPageWidget extends StatelessWidget {
//   //
//   TextEditingController emailCotroller = TextEditingController();
//   TextEditingController passwordCotroller = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   LoginPageWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var logIn_Bloc = Provider.of<LoginBloc>(context, listen: false);

//     //var signUp_Bloc = Provider.of<SignUpBloc>(context, listen: false);

//     var size = MediaQuery.of(context).size;
//     double h = size.height;
//     double w = size.width;
//     double mini = min(h, w);

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             //
//             SizedBox(
//               height: h * 0.1,
//             ),
//             //
//             Card(
//               child: Center(
//                 child: Text(
//                   'KHAN FOODS',
//                   style: TextStyle(
//                       color: Colors.yellow.shade400,
//                       fontSize: mini * 0.09,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             //
//             const SizedBox(
//               height: 5,
//             ),
//             //
//             Form(
//               key: formKey,
//               //
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // First TextFormField

//                   TextFormField(
//                     validator: MultiValidator([
//                       EmailValidator(errorText: 'enter a valid email address'),
//                       RequiredValidator(errorText: ' *required'),
//                     ]),
//                     //
//                     decoration: const InputDecoration(
//                       hintText: 'Enter Email',
//                       prefixIcon: Icon(Icons.email_outlined),
//                       border: OutlineInputBorder(),
//                     ),
//                     controller: emailCotroller,
//                   ),

//                   SizedBox(
//                     height: h * 0.05,
//                   ),

//                   // Second TextFormField

//                   TextFormField(
//                     maxLength: 6,
//                     validator: RequiredValidator(errorText: ' *required'),
//                     obscureText: true,
//                     controller: passwordCotroller,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter Password',
//                       prefixIcon: Icon(Icons.lock),
//                       suffixIcon: Icon(Icons.visibility_off),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   //
//                   SizedBox(
//                     height: h * 0.05,
//                   ),
//                   //
//                   // Login Button
//                   RoundButton(
//                     title: ' LOGIN ',
//                     onTap: () {
//                       if (formKey.currentState!.validate()) {
//                         logIn_Bloc.add(LoginEventApi(
//                             email: emailCotroller.text.toString(),
//                             password: passwordCotroller.text.toString()));
//                       }
//                     },
//                   ),
//                   //
//                   SizedBox(
//                     height: h * 0.03,
//                   ),
//                   //

//                   //row
//                   SizedBox(
//                     height: h * 0.05,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         //
//                         Container(
//                           height: h * 0.003,
//                           width: w * 0.3,
//                           color: Colors.black,
//                         ),
//                         //
//                         SizedBox(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: w * 0.03),
//                             child: Text(
//                               'Or',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                         //
//                         Container(
//                           height: h * 0.003,
//                           width: w * 0.3,
//                           color: Colors.black,
//                         )
//                         //
//                       ],
//                     ),
//                   ),
//                   //
//                   SizedBox(
//                     height: h * 0.05,
//                   ),
//                   //
//                   // Google Button
//                   RoundButton(
//                     title: ' GOOGLE ',
//                     onTap: () {
//                       logIn_Bloc.add(
//                         GoogleLogInEventApi(
//                           logInWithGoogleModel:
//                               LogInWithGoogleModel(loginBy: '2'),
//                         ),
//                       );
//                       /*
//                       if (formKey.currentState!.validate()) {
//                           logIn_Bloc.add(LoginEventApi(
//                               logInDataEvent: LogInApiModel(
//                                   email: emailCotroller.text.toString(),
//                                   password:
//                                       passwordCotroller.text.toString())));
//                         }
//                         googleLogIn();
//                         */
//                     },
//                   ),
//                   //
//                   SizedBox(
//                     height: h * 0.05,
//                   ),
//                   //
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       //
//                       Text("Don't have an acount? "),
//                       InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: ((context) => SignUpPage())));
//                           },
//                           child: Card(
//                               color: Colors.deepOrangeAccent.shade200,
//                               child: Text(
//                                 'Sign Up',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: mini * 0.03,
//                                     fontWeight: FontWeight.bold),
//                               )))
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),

//       /*
//       floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             /*if (formKey.currentState!.validate()) {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const SignUppage(),
//                   ));
//             }*/
//           },
//           tooltip: 'Sign up',
//           child: const Icon(Icons.send),
//         ),*/
//     );
//   }
// }

// class LoginpageWidget extends StatefulWidget {
//   const LoginpageWidget({Key? key}) : super(key: key);

//   @override
//   State<LoginpageWidget> createState() => LoginpageWidgetState();
// }

// class LoginpageWidgetState extends State<LoginpageWidget> {
//   /*
  
//   googleLogIn() async {
//     print('Google LogIn Method');
//     GoogleSignIn googleSignIn = GoogleSignIn();
//     try {
//       var result = await googleSignIn.signIn();
//       print(result!.displayName);
//       print(result.email);
//       print(result.photoUrl);
//       if (result != null) {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const HomePage(),
//             ));
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
  
//   */

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
