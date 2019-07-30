import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

Future<bool> checkNetworkConnection(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("no connection");
//      _showSnackBar(context);
      return false;
    }
    print("intent is ok");
    return true;
  }



 void _showSnackBar(BuildContext context){
       var snackBar = new SnackBar(
          duration: Duration(hours: 1),
          content: GestureDetector(
            onTap: () {
              // _scaffoldKey.currentState.hideCurrentSnackBar();
              Scaffold.of(context).hideCurrentSnackBar();
              // _checkLoggedIn();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("check internet connection"),
                Icon(Icons.perm_scan_wifi),
              ],
            ),
          ));
      // _scaffoldKey.currentState.showSnackBar(snackBar);
      Scaffold.of(context).showSnackBar(snackBar);
 }
  