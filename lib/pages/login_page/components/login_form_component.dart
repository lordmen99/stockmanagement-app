import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stock_app/pages/dashboard_page/dashboard_page.dart';
import 'package:stock_app/services/check_internet_connection_service.dart';
import 'package:stock_app/services/db_services.dart';
import '../../../services/auth_service.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _visible = false;

  String token;

  Future<void> _loggIn(BuildContext context) async {

    Scaffold.of(context).hideCurrentSnackBar();
    // checking network connection and showing snack bar if not connected
    if (await checkNetworkConnection(context)) {
      Map response = await AuthService.sendLoginRequest(body: {
        "email": _emailFieldController.text,
        "password": _passwordFieldController.text
      });

      if (response['error'] == "Unauthorized") {
        var snackBar = SnackBar(
          content: Text("password or email is not correct"),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        DbServices.saveUserTokenApi(response);
        this.token = response['access_token'];
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage(token:this.token ,)),
            (Route<dynamic> route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                new TextFormField(
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter some text';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Email address not valid';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
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
                    hintText: "Email",
                    hintStyle: TextStyle(color: Color(0xff9785B7)),
                    focusColor: Colors.red,
                    hoverColor: Colors.green,
                    prefixStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      FontAwesomeIcons.envelope,
                      color: Color(0xff9785B7),
                      size: 17,
                    ),
                  ),
                  controller: _emailFieldController,
                ),
                new SizedBox(
                  height: 10,
                ),
                new TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _passwordFieldController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must atleast be 8 characters';
                    }
                    return null;
                  },
                  obscureText: _visible ? false : true,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
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
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _loggIn(context);
                        }
                      },
                      child: Text(
                        "Sign in",
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
          )
        ],
      ),
    );
  }
}
