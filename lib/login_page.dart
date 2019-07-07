import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _myController = TextEditingController();


  Future<Map<String, dynamic>> _sendLoginRequest() async {
    var url = "http://10.0.2.2:8000/api/auth/login";
    debugPrint("hahah");
    var response = await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    }, body: jsonEncode({
      'email': 'postmanm@me.com',
      'password': '12345678'
    }));

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }

    throw Exception("Failed to send post api");


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
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: _myController,
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
                      onPressed: () {
//                         Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
//                          print(_myController.text);

                        }
                      },
                      child: Text("login"),
                    ),

                    FutureBuilder<Map<String, dynamic>>(
                      future: _sendLoginRequest(),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return Text(snapshot.data['access_token']);
                        }else if(snapshot.hasError){
                          return Text(snapshot.error.toString());
                        }

                        return CircularProgressIndicator();
                      },
                    )

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
