import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stock_app/services/auth_service.dart';

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


  Future<bool> _register() async{
    final response = await AuthService.sendRegisterRequest(body: {
      "nema" : "ali",
      "email" : "ali@me.com",
      "password" : "12345678"
    });

    if(response['message'] == "Successfully created user!"){
      return true;
    }

    return false;

  }



  final _formKey = GlobalKey<FormState>();
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
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
