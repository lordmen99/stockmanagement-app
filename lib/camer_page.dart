import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart';

//import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  

  Future<void> _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    final String path = (await getApplicationDocumentsDirectory()).path;
    // var file = File('$path/my_image.png');
    // return file;


    final File newImage = await image.copy('$path/avatar_image.png');
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('avatar_image', newImage.path);
    setState(() {
      _imageFile = newImage;
    });
  

    Navigator.pop(_scaffoldKey.currentContext);
setState(() {
  
});
    // _saveUserImage(_imageFile);
  }

  // Future<void> _getImageFromCamera() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     _imageFile = image;
  //   });
  //   Navigator.pop(_scaffoldKey.currentContext);
  //   _saveUserImage(_imageFile);
  // }

  // Future<bool> _saveUserImage(File imageFile)async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   bool result = await sharedPreferences.setString("avatar_image", imageFile.toString());
  //   print(result);
  //   return result;
  // }

  Future<String> _getUserImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.containsKey("avatar_image")){
      print("yes we have image storaged");
      String imagePath = sharedPreferences.getString("avatar_image");
      _imageFile = (File(imagePath));
      var ss= FileImage(_imageFile);
      ss.toString();
      final String path = (await getApplicationDocumentsDirectory()).path;
      final File newImage = await _imageFile.copy('$path/avatar_image.png');
      
      setState(() {
        _imageFile=newImage;
      });
      print(newImage);
      print(ss.toString());
      return imagePath;
      // setState(() {
      //   print("image path is : $imagePath");
      //   _imageFile = File(imagePath);
      //   print("image file is : $_imageFile");
      // });
    }
    throw Exception("no image stored");
  }
  @override
  void initState() {
    _getUserImage();
    
    super.initState();
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
                      _getImageFromGallery();
                    },
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      print("camera");
                      // _getImageFromCamera();
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
File _imageFile;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Camera Page"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // FutureBuilder(future: _getUserImage(),),
            _imageFile == null ? Text("no image") :
             Image.file(_imageFile),
            // FileImage(File(prefs.getString('avatar_image')),
          RaisedButton(
            child: Text("load"),
            onPressed: _getUserImage,
          ),
          
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.camera),
      ),
    );
  }
}
