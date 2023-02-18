import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khan_foods/Utils/SplashServices/Splash_Service.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({this.check, Key? key}) : super(key: key);
  bool? check;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices services = SplashServices();
  @override
  void initState() {
    super.initState();
    services.login(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      color: Colors.white,
      height: height,
      width: width,
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(colors: [
      //     Color(0xFF6B5E55),
      //     Color(0xFF5D5047),
      //     Color(0xFF423731),
      //     Color(0xFF382D27),
      //     Color(0xFF302720),
      //   ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
      // ),
      child: Column(
        children: [
          SizedBox(
            height: 0.05,
          ),
          SizedBox(
            //color: Colors.white,
            // color: Colors.green,
            height: height * 0.30,
            child: Image.asset('assets/image/d5.gif'),
          ),
          SizedBox(
            //color: Colors.white,
            height: height * 0.30,
            child: Image.asset('assets/image/d7.gif'),
          ),
          SizedBox(
            // color: Colors.white,
            height: height * 0.30,
            child: Image.asset('assets/image/d4.gif'),
            //child: Image.asset('assets/image/KhanFoods.png'),
          ),
          SizedBox(
            height: 0.05,
          ),
        ],
      ),
    ));
  }
}
