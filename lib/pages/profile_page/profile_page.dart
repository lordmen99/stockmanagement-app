import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/pages/home_page/my_home_page.dart';
import '../../services/camera_services.dart';
import '../../theme/style.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _imageFiel;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> _selectPhotoFromGallary() async {
    var image = await getImageFromGallery();
    setState(() {
      _imageFiel = image;
    });
    Navigator.pop(context);
  }

  Future<void> _selectPhotoFromCamera() async {
    var image = await getImageFromCamera();
    setState(() {
      _imageFiel = image;
    });
    Navigator.pop(context);
  }

  Future<void> _userLogot() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  title: "My home page",
                )));

    return;
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(("choise your way")),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      print("gallery");
                      _selectPhotoFromGallary();
                    },
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      print("camera");
                      _selectPhotoFromCamera();
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("close"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              maxRadius: 56,
              backgroundColor: buttonColor,
              backgroundImage: _imageFiel == null
                  ? AssetImage("assets/avatar.png")
                  : FileImage(_imageFiel),
              // child: _imageFiel == null ? Image.asset("assets/avatar.png"): Image.file(_imageFiel),
            ),
            SizedBox(
              height: 34,
            ),
            Container(
              width: 162,
              height: 48,
              child: RaisedButton(
                onPressed: () {
                  _showDialog();
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5),
                ),
                color: buttonColor,
                child: Text(
                  "select photo",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Container(
              width: 162,
              height: 48,
              margin: EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: () {
                  print("log out");
                  _userLogot();
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5),
                ),
                color: Colors.blueGrey,
                child: Text(
                  "log out",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
