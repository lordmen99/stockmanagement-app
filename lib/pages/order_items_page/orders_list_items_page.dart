import 'package:flutter/material.dart';
import './components/components.dart';
import '../../models/orders_list_items.dart';
import '../../theme/style.dart';

class OrderItemsPage extends StatelessWidget {
  final Order order;

  OrderItemsPage({this.order});

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
                "List of Orders list items",
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
            order.orderItems.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(35),
                      itemCount: order.orderItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardItem(
                          status: order.orderItems[index].status.toString(),
                          productTitle: order.orderItems[index].product.name,
//                           imageUrl: ordersItems[index].product.images == null ? "null" : ordersItems[index].product.images.first.url,
                          imageUrl:
                              "http://10.0.3.2:8000/images/1561188950.41WglAapeDL.jpg",
                          count: order.orderItems[index].qty,
                        );
                      },
                    ),
                  )
                : Text(
                    "List is Empty",
                    style: TextStyle(color: Colors.green, fontSize: 19),
                  ),
          ],
        ),
      ),
    );
  }
}

// var listView = ListView(
//   padding: EdgeInsets.all(35),
//   children: <Widget>[
//     CardItem(
//       status: Status.Checking,
//       productTitle: "MacBook Air",
//       count: 45,
//     ),
//     CardItem(
//       status: Status.Approved,
//       productTitle: "Iphone X Max",
//       count: 5,
//     ),
//     CardItem(
//       status: Status.Canceled,
//       productTitle: "Imac 2019",
//       count: 5,
//     ),
//   ],
// );
