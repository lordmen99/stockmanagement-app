import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stock_app/models/orders_list_items.dart';
import 'package:stock_app/pages/dashboard_page/dashboard_page.dart';
import 'package:stock_app/pages/welcome_page/welcome_page.dart';
import 'package:stock_app/pages/home_page/my_home_page.dart';
import 'package:stock_app/services/api_services.dart';
import 'package:stock_app/services/db_services.dart';
import 'package:stock_app/services/file_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String token;

  startTime(Function callBack) {
    return new Timer(Duration(seconds: 5), callBack);
  }

  Future<void> _checkLoggedIn() async {
    bool isLoggedIn = await DbServices.userTokenApiIsAvailable();
    if (isLoggedIn) {
      this.token = await DbServices.getUserTokenApi();
//      try{
////        OrdersList ordersList =  await getOrdersList(token:token);
////        if(ordersList!=null){
////          Map map = ordersList.toJson();
////
////          await jsonStorage.writeJsonFile(map.toString());
////        }
//
//
//      }catch(e){
//        print(e.toString());
//      }


      startTime(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashboardPage(token: this.token,)));
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
    super.initState();
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
