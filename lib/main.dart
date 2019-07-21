import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_app/pages/profile_page/profile_page.dart';
import 'package:stock_app/pages/register_page/register_page.dart';
import 'package:image_picker/image_picker.dart';

import 'package:stock_app/pages/splash_page/splash_screen.dart';
import 'package:stock_app/pull_to_refresh.dart';
import 'package:stock_app/tab_page.dart';

import 'camer_page.dart';
import 'data_page.dart';


void main() {
  runApp(MyApp());
//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//
//  ));
//  SystemChrome.setEnabledSystemUIOverlays([]);

}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Rubik",
        primarySwatch: Colors.purple,
      ),
      home: SplashScreen(),//RegisterPage(),//MyHomePage(title: 'Stock Management App'),
    );
  }
}
