import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stock_app/pages/login_page/login_page.dart';

import 'components/buttons_component.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
//              stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Color(0xff4B2D83),
              Color(0xff261742),
            ],
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              Column(
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
                      "INVENTORY",
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
              ButtonComponnets(),
            ],
          ),
        ),
      ),
    );
  }
}
