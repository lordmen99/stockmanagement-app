import 'package:flutter/material.dart';


import 'components/my_cutom_form_component.dart';

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
          child: MyCustomFormPage()),
    );
  }
}

