import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stock_app/pages/dashboard_page/dashboard_page.dart';
import 'package:stock_app/services/auth_service.dart';
import 'package:stock_app/services/db_services.dart';

class MyCustomFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: MyCustomForm(),
            ),
          )
        ],
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  String token;
  Future<bool> _register(BuildContext context) async {
    final response = await AuthService.sendRegisterRequest(body: {
      "email": _emailFieldController.text,
      "name": _namelFieldController.text,
      "password": _passwordFieldController.text,
      "role": "Simple User"
    });

    if (response['status'] == "successful") {
      DbServices.saveUserTokenApi(response['responde']);
      this.token = response['responde']['access_token'];
      print(response['responde']);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage(token: this.token,)),
          (Route<dynamic> route) => false);
      return true;
    }
    // print(response);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("some thing sent wrong!"),
    ));
    throw Exception("some thing sent wrong");
  }

  final _formKey = GlobalKey<FormState>();
  bool _visible = false;
  final _namelFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _passwordFieldController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _namelFieldController,
            focusNode: FocusNode(),
            style: TextStyle(color: Colors.white),
            validator: (value) {
              if (value.isEmpty) {
                return 'name Required';
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
            controller: _emailFieldController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty) {
                return 'email Required';
              }
              return null;
            },
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
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            controller: _passwordFieldController,
            style: TextStyle(color: Colors.white),
            obscureText: _visible ? false : true,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value.isEmpty) {
                return 'Password Required';
              } else if (value.length < 8) {
                return "The Password Requires 8 Characters Or More";
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
                    _visible ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
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
            controller: _passwordFieldController2,
            style: TextStyle(color: Colors.white),
            obscureText: _visible ? false : true,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter password';
              } else if (value.length < 8) {
                return "The Password Requires 8 Characters Or More";
              } else if (value != _passwordFieldController.text) {
                return 'Passwrod is not matching';
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
                    _visible ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
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
                    _register(context);
                  }

                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                },
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
    );
  }
}
