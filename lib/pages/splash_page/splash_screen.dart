import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/pages/welcome_page/welcome_page.dart';

import 'package:stock_app/pages/login_page/login_page.dart';

import 'package:stock_app/pages/home_page/my_home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  startTime(Function callBack){
    return new Timer(Duration(seconds: 5), callBack);
  }

  Future<void> _getUserTokenApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    sharedPreferences.clear();
//    return ;

    if(sharedPreferences.containsKey("user_api_token")){
      final token =  sharedPreferences.getString("user_api_token");
//      print(token);
      startTime((){
//        Navigator.popUntil(
//            context,
//            ModalRoute.withName(
//                Navigator.defaultRouteName));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WelcomePage()));
      });

    }else{
      startTime((){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "My Home Page",)));
      });
    }
//    print(token);
//
//

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    startTime();
    _getUserTokenApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(
                Icons.assignment,
                size: 40,
                color: Colors.white,
              ),
              margin: EdgeInsets.only(bottom: 20),
            ),
            Text(
              "Stock Management App",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
