import 'package:flutter/material.dart';
import 'package:stock_app/pages/login_page/login_page.dart';
import 'package:stock_app/pages/register_page/register_page.dart';

class ButtonComponnets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 25),
          child: Container(
            margin: EdgeInsets.only(top: 47),
            child: SizedBox(
              width: 262,
              height: 48,
              child: RaisedButton(
                elevation: 0,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
                color: Color(0xff5FD247),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

                },
                child: Text(
                  "login in",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Rubik-Regular",
                      fontSize: 18),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 25),
          child: Container(
            child: SizedBox(
              width: 262,
              height: 48,
              child: RaisedButton(
                elevation: 0,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
                color: Color(0xffD247C9),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Rubik-Regular",
                      fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
