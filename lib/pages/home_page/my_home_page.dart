import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stock_app/pages/login_page/login_page.dart';

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  Future<Post>fetchData() async {
    String url = "https://jsonplaceholder.typicode.com/posts/1";
    var response = await http.get(url);

    if(response.statusCode == 200){

      Post post = Post.fromJson(jsonDecode(response.body));
      return post;

    }else{
      throw Exception('Failed to load post');
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginPage()),
                );
              },
              child: Text("Login"),
            ),
            RaisedButton(
              onPressed: fetchData,
              child: Text("fetch data"),
            ),
            FutureBuilder<Post>(
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Text(snapshot.data.title);
                }
                else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();

              },
              future: fetchData(),
            ),

          ],
        ),
      ),
    );
  }
}


class Post{
  int id;
  int userId;
  String title;
  String body;

  Post(this.id, this.userId, this.title, this.body);

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      json['id'],
      json['userId'],
      json['title'],
      json['body'],
    );
  }

}