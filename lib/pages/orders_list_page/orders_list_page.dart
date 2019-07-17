import 'package:flutter/material.dart';
import 'package:stock_app/pages/orders_list_page/components/components.dart';
import '../../theme/style.dart';

class OrdersListPage extends StatefulWidget {
  @override
  _OrdersListPageState createState() => _OrdersListPageState();
}

class _OrdersListPageState extends State<OrdersListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 65, bottom: 20),
              child: Text(
                "List of orders",
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(35),
                children: <Widget>[
                  CardItem(
                    status: Status.Checking,
                    productTitle: "MacBook Air",
                    count: 45,
                  ),
                  CardItem(
                    status: Status.Approved,
                    productTitle: "Iphone X Max",
                    count: 5,
                  ),
                  CardItem(
                    status: Status.Canceled,
                    productTitle: "Imac 2019",
                    count: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
