import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stock_app/pages/welcome_page/welcome_page.dart';
import 'package:stock_app/pages/home_page/my_home_page.dart';
import 'package:stock_app/services/db_services.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime(Function callBack) {
    return new Timer(Duration(seconds: 5), callBack);
  }

  Future<void> _checkLoggedIn() async {
    bool isLoggedIn = await DbServices.userTokenApiIsAvailable();
    if (isLoggedIn) {
      startTime(() {
//        Navigator.popUntil(
//            context,
//            ModalRoute.withName(
//                Navigator.defaultRouteName));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
      });
    } else {
      startTime(() {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      title: "My Home Page",
                    )));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    startTime();
    _checkLoggedIn();
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
