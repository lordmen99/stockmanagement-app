import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import './models/json_response.dart';
import 'package:async/async.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  Future<LoginResponse> _loginResponse;

  bool _isLoggedIn = false;

  Future<LoginResponse> _sendLoginRequest({Map body}) async {
    var url = "http://10.0.2.2:8000/api/auth/login";

    var response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        _isLoggedIn = true;
      });
      return LoginResponse.fromJson(jsonResponse);
    }

//    throw Exception("Failed to send post api");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Login here"),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
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
                      onPressed: (){


                        if(_formKey.currentState.validate()){
                           _loginResponse = _sendLoginRequest(body: {
                            "email": _emailFieldController.toString(),
                            "password": _passwordFieldController.toString()
                          });
                          setState(() {
                            print(_loginResponse.then((value){print(value.accessToken);}));
                            _isLoggedIn = true;
                          });
                        }
                      },
                      child: Text("login in"),
                    ),
                    _isLoggedIn
                        ? LoginAlert(_loginResponse)
                        : Text("you have to logged in"),
//                  _isLoggedIn ? Text("Welcome ") : Text("you have to logged in"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginAlert extends StatelessWidget {
//  final _isLoggedIn;
//  bool _isLoading = true;

  Future<LoginResponse> _loginResponse;

  LoginAlert(this._loginResponse);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<LoginResponse>(
        future: _loginResponse,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            return Text("Welcome");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
