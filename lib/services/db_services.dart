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


  static Future<String> getUserTokenApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if(sharedPreferences.containsKey("user_api_token")){
      final token =  sharedPreferences.getString("user_api_token");
      return token;

    }else{
      throw Exception("api token not found!");
    }
  }

}

