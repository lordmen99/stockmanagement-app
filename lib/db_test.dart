import 'package:flutter/material.dart';
import 'package:stock_app/sqllite_provider/product_provider.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> saveProduct() async{
    var db = new ProductProvider();
    await db.open();
    var resilt = await db.insert();
    print(resilt);
    await db.close();
  }

  @override
  void initState() {
    saveProduct();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("db"),
      ),
    );
  }
}
