import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/pages/home_page/my_home_page.dart';
import 'package:stock_app/services/api_services.dart';
import '../../services/camera_services.dart';
import '../../theme/style.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class ProfilePage extends StatefulWidget {
  final String token;

  ProfilePage({this.token});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _imageFiel;

  Future<void> _uploadPhoto() async {
    var stream = new http.ByteStream(
        DelegatingStream.typed(_imageFiel.openRead()));
    var lenght = await _imageFiel.length();
    var uri = Uri.parse("https://inventory.azaronline.com/public/api/profile/upload");
    var request = http.MultipartRequest("POST", uri);

    var multyFile = new http.MultipartFile(
      "user_photo", stream, lenght, filename: basename(_imageFiel.path),);
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": "bearer ${widget.token}"
    };
    request.headers.addAll(headers);
    request.files.add(multyFile,);
    var response = await request.send();


    if (response.statusCode == 200) {
      print("file uploaded");
    } else {
      print("file not uploaded");
    }
    print(response.statusCode);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var url;

  Future<void> _selectPhotoFromGallary() async {
    var image = await getImageFromGallery();
    setState(() {
      _imageFiel = image;
    });
    _uploadPhoto();
    Navigator.pop(_scaffoldKey.currentContext);
  }

  Future<void> _selectPhotoFromCamera() async {
    var image = await getImageFromCamera();
    setState(() {
      _imageFiel = image;
    });
    _uploadPhoto();
    Navigator.pop(_scaffoldKey.currentContext);
  }

  Future<void> _userLogot() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushReplacement(
        _scaffoldKey.currentContext,
        MaterialPageRoute(
            builder: (context) =>
                MyHomePage(
                  title: "My home page",
                )));

    return;
  }

  void _showDialog() {
    showDialog(
        context: _scaffoldKey.currentContext,
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadPhoto, child: Icon(Icons.update),),
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text("Name : Sajad Sohrabi" ,style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text("Email : Sajad Sohrabi@gmail.com" ,style: TextStyle(color: Colors.white, fontSize: 19),),
            ),

            FutureBuilder<String>(
              future: getUserImage(widget.token),
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                return CircleAvatar(
                maxRadius: 56,
                backgroundImage: NetworkImage(snapshot.data),
                );
                return Container(
                width: 100,
                decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(0)
                ),
                child: Image.network(snapshot.data,),
                );
                } if(snapshot.hasError){
                print("fghfgh");
                print(snapshot.error);
                }

                return CircularProgressIndicator();
              },
            ),


//            CachedNetworkImage(
//
//              placeholder: (context, url) => CircularProgressIndicator(),
//              imageUrl:
//              "https://picsum.photos/250?image=9",
//            ),

//            CircleAvatar(
//              maxRadius: 56,
//              backgroundColor: buttonColor,
//              backgroundImage: Image.network(src)
////              _imageFiel == null
////                  ? AssetImage('assets/avatar.png')
//////                  ? Image.network(url)
////                  : FileImage(_imageFiel),
//              // child: _imageFiel == null ? Image.asset("assets/avatar.png"): Image.file(_imageFiel),
//            ),
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
