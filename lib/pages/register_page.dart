import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    FlutterStatusbarcolor.setStatusBarColor(Colors.deepPurple);
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
//      backgroundColor: Colors.yellow,
//      appBar: AppBar(
//        title: Text("Register Page"),
//      ),
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
          child: MyCustomForm()),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.start,
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
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.white,
//                primaryColorDark: Colors.red,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      focusNode: FocusNode(),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter some text';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 1,
                        )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff9785B7),
                          width: 1,
                        )),
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Name",
                        hintStyle: TextStyle(color: Color(0xff9785B7)),
                        focusColor: Colors.red,
                        hoverColor: Colors.green,
                        prefixStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          FontAwesomeIcons.pen,
                          color: Color(0xff9785B7),
                          size: 17,
                        ),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter some text';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 1,
                        )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff9785B7),
                          width: 1,
                        )),
                        suffixStyle: TextStyle(color: Colors.green),
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Color(0xff9785B7)),
                        prefixIcon: Icon(
                          FontAwesomeIcons.envelope,
                          color: Color(0xff9785B7),
                          size: 17,
                        ),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      obscureText: _visible ? false : true,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 1,
                        )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff9785B7),
                          width: 1,
                        )),
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Password",
                        suffixIcon: IconButton(
                            icon: Icon(
                              _visible
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              color: Color(0xff9785B7),
                              size: 17,
                            ),
                            onPressed: () {
                              setState(() {
                                _visible = !_visible;
                              });
                            }),
                        hintStyle: TextStyle(color: Color(0xff9785B7)),
                        prefixIcon: Icon(
                          FontAwesomeIcons.dotCircle,
                          color: Color(0xff9785B7),
                          size: 17,
                        ),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      obscureText: _visible ? false : true,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 1,
                        )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff9785B7),
                          width: 1,
                        )),
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                            icon: Icon(
                              _visible
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              color: Color(0xff9785B7),
                              size: 17,
                            ),
                            onPressed: () {
                              setState(() {
                                _visible = !_visible;
                              });
                            }),
                        hintStyle: TextStyle(color: Color(0xff9785B7)),
                        prefixIcon: Icon(
                          FontAwesomeIcons.dotCircle,
                          color: Color(0xff9785B7),
                          size: 17,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 47),
                      child: SizedBox(
                        width: 262,
                        height: 48,
                        child: RaisedButton(
                          elevation: 0,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                          color: Color(0xff5FD247),
                          onPressed: () {},
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik-Regular",
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
