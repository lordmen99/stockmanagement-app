import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class DbServices {
  static Future<bool> saveUserTokenApi(Map response) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString(
        "user_api_token", response['access_token']);
    print(result);
    return result;
  }

  static startTime(Function callBack) {
    return new Timer(Duration(seconds: 5), callBack);
  }

  static Future<bool> userTokenApiIsAvailable() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.containsKey("user_api_token")){
      return true;
    }

    return false;
  }

//  static Future<void> _getUserTokenApi() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
////    sharedPreferences.clear();
////    return ;
//
//    if(sharedPreferences.containsKey("user_api_token")){
//      final token =  sharedPreferences.getString("user_api_token");
////      print(token);
//      startTime((){
////        Navigator.popUntil(
////            context,
////            ModalRoute.withName(
////                Navigator.defaultRouteName));
//        Navigator.pushReplacement(
//            context,
//            MaterialPageRoute(
//                builder: (context) => WelcomePage()));
//      });
//
//    }else{
//      startTime((){
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "My Home Page",)));
//      });
//    }
////    print(token);
////
////
//
//  }

}

