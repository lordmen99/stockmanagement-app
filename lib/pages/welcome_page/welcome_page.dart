import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stock_app/pages/login_page/login_page.dart';

import 'package:stock_app/pages/home_page/my_home_page.dart';

class WelcomePage extends StatefulWidget {



  @override
  _WelcomePageState createState() => _WelcomePageState();
}

List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(title: 'Logoute', icon: Icons.exit_to_app),
  CustomPopupMenu(title: 'Bookmarks', icon: Icons.bookmark),
  CustomPopupMenu(title: 'Settings', icon: Icons.settings),
];


class _WelcomePageState extends State<WelcomePage> {
  CustomPopupMenu _selectedChoices = choices[0];

  void _select(CustomPopupMenu choice) {
    if(choice.title == "Logoute"){
      _userLogot();
    }


    setState(() {
      _selectedChoices = choice;
    });
  }

  @override
  Widget build(BuildContext context) {





    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Page"),
        actions: <Widget>[
          PopupMenuButton<CustomPopupMenu>(
            elevation: 3.2,
            initialValue: _selectedChoices,
//            onCanceled: () {
//              print('You have not chossed anything');
//            },
            tooltip: 'This is tooltip',
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((CustomPopupMenu choice) {
                return PopupMenuItem<CustomPopupMenu>(
                  value: choice,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                    Text(choice.title),
                    Icon(choice.icon),
                  ],),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Center(
        child: Text("Welcome"),
      ),
    );
  }

  Future<void> _userLogot() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(title: "My home page",)));

    return;
  }
}

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon});

  String title;
  IconData icon;
}