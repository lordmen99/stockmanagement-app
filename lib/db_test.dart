import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import './sqllite_provider/b_util.dart';
import 'models/orders_list_items.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> saveOrder() async {
    Order order = new Order(
      id: 1,
      createdAt: DateTime.parse("2019-06-26 06:36:49"),
      updatedAt: DateTime.parse("2019-06-26 06:36:49"),
      orderItems: [],
      status: OrderStatus.OPEN,
      userId: 1
    );


    var db_helper  = DatabaseHelper();
    await db_helper.initializeDatabase();
//    int id = await db_helper.insertOrder(order);
//    print(id.toString());
      List<Map> orders = await db_helper.getOrderMapList();

      print(orders);




  }

  @override
  void initState() {
    saveOrder();
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
