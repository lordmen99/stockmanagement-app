import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_app/pages/register_page.dart';

import './pages/splash_screen.dart';

void main() {
  runApp(MyApp());
//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//
//  ));
  SystemChrome.setEnabledSystemUIOverlays([]);

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
      home: RegisterPage(),//MyHomePage(title: 'Stock Management App'),
    );
  }
}
