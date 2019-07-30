import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stock_app/models/orders_list_items.dart';
import 'package:stock_app/services/api_services.dart';
import 'package:stock_app/sqllite_provider/new_sql_provider.dart';

class NewSqlTestPage extends StatefulWidget {
  @override
  _NewSqlTestPageState createState() => _NewSqlTestPageState();
}

class _NewSqlTestPageState extends State<NewSqlTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sql test page"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
//                OrderItem orderItem = new OrderItem(
//                  id: 1,
//                  comment: "Hello",
//                  createdAt: DateTime.parse("2019-06-26 06:36:49"),
//                  updatedAt: DateTime.parse("2019-06-26 06:36:49"),
//                  orderId: 1,
//                  product: null,
//                  productId: 1,
//                  qty: 12,
//                  status: OrderItemStatus.APPROVED
//                );
//
//                Order order = new Order(
//                  id: 1,
//                  status: OrderStatus.OPEN,
//                  userId: 623,
//                  createdAt: DateTime.parse("2019-06-26 06:36:49"),
//                  updatedAt: DateTime.parse("2019-06-26 06:36:49"),
//                  orderItems: [orderItem]
//                );

//                NewSqlProvider newSqlProvider = new NewSqlProvider();
//                await newSqlProvider.getDatabase();
//                // await newSqlProvider.insertOrder(order);
//                List<Map> maps = await newSqlProvider.getOrder();
//                print(maps);

                // await newSqlProvider.deleteMyDatabase();
              },
              child: Text("insert order"),
            ),
          ],
        ),
      ),
    );
  }
}
