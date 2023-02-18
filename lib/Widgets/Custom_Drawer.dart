import 'package:flutter/material.dart';
import 'package:khan_foods/Screens/Cart_Screen.dart';
import 'package:khan_foods/Screens/Home_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({this.email, Key? key}) : super(key: key);
  String? email;
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(4.0))),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF6B5E55),
              Color(0xFF5D5047),
              Color(0xFF423731),
              Color(0xFF382D27),
              Color(0xFF302720),
            ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
          ),
          child: Column(
            children: [
              DrawerHeader(
                child: Container(
                  width: width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF6B5E55),
                      Color(0xFF5D5047),
                      Color(0xFF423731),
                      Color(0xFF382D27),
                      Color(0xFF302720),
                    ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
                  ),
                  child: Center(
                      child: Text(
                    widget.email.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  )),
                ),
              ),
              //Header is End Here

              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePageScreen(),
                      ));
                },
                leading: const Icon(
                  Icons.workspaces,
                  color: Color(0xFFCAA21E),
                ),
                title: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Home',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePageScreen(),
                      ));
                },
                // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));},
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Color(0xFFCAA21E),
                ),
                title: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'My Cart',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ));
                },
                // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));},
                leading: const Icon(
                  Icons.shopping_basket,
                  color: Color(0xFFCAA21E),
                ),
                title: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'My Order',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ),
              ),
              ListTile(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.remove('islogin');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ));
                  // Navigator.pop(context);
                },

                // onTap: ()async{
                //   SharedPreferences pref =await SharedPreferences.getInstance();
                //   pref.remove('islogin');
                //   Navigator.pop(context);

                // },
                leading: Icon(
                  Icons.logout,
                  color: Color(0xFFCAA21E),
                ),
                title: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Colors.brown.shade300,
      child: Column(
        children: [
          //icon
          SizedBox(
            height: height * 0.1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: width * 0.02),
                child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          //text
          SizedBox(
            height: height * 0.2,
            child: const Center(
                child: Text(
              'Welcome',
              style: TextStyle(color: Colors.yellow),
            )),
          ),
          //listTile
          SizedBox(
            height: height * 0.1,
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return HomePageScreen();
                  },
                ));
              },
              leading: const Icon(
                Icons.home,
                color: Colors.yellow,
              ),
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          //listTile
          SizedBox(
            height: height * 0.1,
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return HomePageScreen();
                    //homeScreen();
                  },
                ));
              },
              leading: const Icon(
                Icons.add_shopping_cart,
                color: Colors.yellow,
              ),
              title: const Text(
                'My Cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          //listTile
          SizedBox(
            height: height * 0.1,
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return HomePageScreen();
                    //CheckoutScreen();
                  },
                ));
              },
              leading: const Icon(
                Icons.opacity_rounded,
                color: Colors.yellow,
              ),
              title: const Text(
                'My Order',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          //listTile
          SizedBox(
            height: height * 0.1,
            child: const ListTile(
              // onTap: () async {
              //   int id = 0;
              //   SharedPreferences sharedPrefrences =
              //       await SharedPreferences.getInstance();
              //   sharedPrefrences.setInt('ClientId', id);
              //   Provider.of<SignInBloc>(context, listen: false)
              //       .add(SignInInitialEvent());
              //   Navigator.pushReplacement(context, MaterialPageRoute(
              //     builder: (context) {
              //       return SignInScreen();
              //     },
              //   ));
              // },
              leading: Icon(
                Icons.assignment_outlined,
                color: Colors.yellow,
              ),
              title: Text(
                'SignOut',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
