import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stock_app/pages/welcome_page/welcome_page.dart';
import 'package:stock_app/pages/home_page/my_home_page.dart';
import 'package:stock_app/services/db_services.dart';
import 'package:connectivity/connectivity.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  startTime(Function callBack) {
    return new Timer(Duration(seconds: 5), callBack);
  }

  Future<void> _checkLoggedIn() async {
    bool isLoggedIn = await DbServices.userTokenApiIsAvailable();
    if (await _checkNetworkConnection()) {
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
                  builder: (context) =>
                      MyHomePage(
                        title: "My Home Page",
                      )));
        });
      }
    } else {
      var snackBar = new SnackBar(
          duration: Duration(hours: 1),
          content: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
              _checkLoggedIn();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("check internet connection"),
                Icon(Icons.perm_scan_wifi),
              ],
            ),
          ));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }


  Future<bool> _checkNetworkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("no connection");
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
  //  startTime((){});x
    _checkLoggedIn();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 55),
                  child: SvgPicture.asset(
                    "assets/logo.svg",
                    width: 210,
                    height: 96,
                  )),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  "FASTBOX",
                  style: TextStyle(
                      fontFamily: "Rubik-Regular",
                      fontSize: 40,
                      color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 85),
                child: Text(
                  "Lorem ipsum",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff9785B7),
                      fontFamily: "Rubik-Light"),
                ),
              ),
            ],
          ),
              margin: EdgeInsets.only(bottom: 20),
            ),
            // Text(
            //   "Stock Management App",
            //   style: TextStyle(color: Colors.white, fontSize: 24),
            // ),
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
