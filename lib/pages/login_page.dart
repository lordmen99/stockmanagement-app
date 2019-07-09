import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import './welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import '../models/json_response.dart';
import 'package:async/async.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
//  final BuildContext context;
//  LoginPage(this.context);
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

//  LoginResponse _loginResponse;
//
//  bool _isLoggedIn = false;
//  bool _isLoding = false;
//
//  Future<void> _sendLoginRequest({Map body}) async {
//    setState(() {
//      _isLoding = true;
//    });
//    var url = "http://10.0.2.2:8000/api/auth/login";
//
//    var response = await http.post(url,
//        headers: {
//          HttpHeaders.contentTypeHeader: 'application/json',
//        },
//        body: jsonEncode({
//          "email": _emailFieldController.text,
//          "password": _passwordFieldController.text
//        }));
//    print(_emailFieldController.text);
//    print(_passwordFieldController.text);
//    if (response.statusCode == 200) {
//      setState(() {
//        final jsonResponse = jsonDecode(response.body);
//        _isLoggedIn = true;
//        _loginResponse = LoginResponse.fromJson(jsonResponse);
//        print(_loginResponse);
//        _isLoding = false;
//      });
//      print(response.body);
//      return;
//    }
//    setState(() {
//      _isLoggedIn = false;
//      _isLoding = false;
//    });
//  }

  Future<bool> _saveUserTokenApi(Map response) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString("user_api_token", response['access_token']);
    print(result);
    return result;
  }

  Future<void> _getUserTokenApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token =  sharedPreferences.getString("user_api_token");
    print(token);
    Navigator.popUntil(
        context,
        ModalRoute.withName(
            Navigator.defaultRouteName));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WelcomePage()));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _getUserTokenApi();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: Builder(
        builder: (context) => Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Login here" ,style: TextStyle(color: Colors.purple,fontSize: 24),),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter some text';
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return 'Email address not valid';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "email",
                            ),
                            controller: _emailFieldController,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
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
                              obscureText: true,
                              decoration: InputDecoration(hintText: "Password"),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                Map response =
                                    await AuthService.sendLoginRequest(body: {
                                  "email": _emailFieldController.text,
                                  "password": _passwordFieldController.text
                                });

                                if (response['message'] == "Unauthorized") {
                                  var snackBar = SnackBar(
                                    content: Text(
                                        "password or email is not correct"),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  _saveUserTokenApi(response);
//                                  print(_saveUserTokenApi(response));
                                  Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          Navigator.defaultRouteName));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WelcomePage()));
                                }
                              }
                            },
                            child: Text("login in"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
      ),
    );
  }
}

//
//class LoginAlert extends StatelessWidget {
////  final _isLoggedIn;
////  bool _isLoading = true;
//
//  Future<LoginResponse> _loginResponse;
//
//  LoginAlert(this._loginResponse);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: FutureBuilder<LoginResponse>(
//        future: _loginResponse,
//        builder: (context, snapshot) {
//          if (snapshot.hasError) {
//            return Text(snapshot.error.toString());
//          } else if (snapshot.hasData) {
//            return Text("Welcome");
//          }
//          return CircularProgressIndicator();
//        },
//      ),
//    );
//  }
//}
