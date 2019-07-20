import 'package:flutter/material.dart';
import 'package:stock_app/models/orders_list_items.dart';
import 'package:stock_app/pages/order_items_page/orders_list_items_page.dart';
import 'package:stock_app/services/api_services.dart';
import 'package:stock_app/theme/style.dart';

class OrdersPage extends StatelessWidget {
  final String token;

  OrdersPage({this.token});

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
                "List of Orders",
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
            FutureBuilder<OrdersList>(
              future: getOrdersList(token: this.token),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  OrdersList ordersList = snapshot.data;
                  if (ordersList.orders.isEmpty) {
                    return Text(
                      "List is Empty",
                      style: TextStyle(color: Colors.green, fontSize: 19),
                    );
                  }
                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(35),
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.white,
                      ),
                      itemCount: ordersList.orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            "Order : " + index.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderItemsPage(
                                          order: ordersList.orders[index],
                                        )));
                          },
                        );
                      },
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
