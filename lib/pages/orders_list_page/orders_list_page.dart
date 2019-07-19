import 'package:flutter/material.dart';
import 'package:stock_app/pages/orders_list_page/components/components.dart';
import 'package:stock_app/services/api_services.dart';
import '../../models/orders_list.dart';
import '../../theme/style.dart';

class OrdersListPage extends StatefulWidget {
  @override
  _OrdersListPageState createState() => _OrdersListPageState();
}

class _OrdersListPageState extends State<OrdersListPage> {
  // final OrdersList ordersList;

  // Future _getOrdersListModel() async{
  //   this.ordersList = await getOrdersList();
  // }

  @override
  void initState() {
    getOrdersList(token: token);
    super.initState();
  }

  final token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAwMFwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2MzUyMTcyNSwibmJmIjoxNTYzNTIxNzI1LCJqdGkiOiJoSUZLMERadTc4NnI1TVVJIiwic3ViIjo4LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.M7LRTKii-z3UUb4joht-lT35TruJUz3I3PP4fws4UKU";

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
            FutureBuilder<OrdersList>(
              future: getOrdersList(token: token),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<OrderItem> ordersItems =
                      snapshot.data.orders[0].orderItems;

                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(35),
                      itemCount: ordersItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        // return Text(
                        //   ordersItems[index].status.toString(),
                        //   style: TextStyle(color: Colors.white, fontSize: 24),
                        // );
                        return CardItem(
                          // status: Status.Checking,
                          // status: "APPROVED",
                          status: ordersItems[index].status.toString(),
                          productTitle: ordersItems[index].product.name,
                          // imageUrl: ordersItems[index].product.images == null ? "null" : ordersItems[index].product.images.first.url,
                          imageUrl: "http://localhost:8000/images/1561961247.41WglAapeDL.jpg",
                          count: 45,
                        );
                        return Text(ordersItems[index].qty.toString());
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
