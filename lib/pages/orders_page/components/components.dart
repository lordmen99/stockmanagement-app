import 'package:flutter/material.dart';
import 'package:stock_app/pages/order_items_page/orders_list_items_page.dart';
import 'package:stock_app/models/orders_list_items.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//class RefreshBackground extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return SliverAppBar(
//      expandedHeight: 200.0,
//      flexibleSpace: FlexibleSpaceBar(
//        background: Image.network(
//          "https://images.unsplash.com/photo-1541701494587-cb58502866ab?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=0c21b1ac3066ae4d354a3b2e0064c8be&auto=format&fit=crop&w=500&q=60",
//          fit: BoxFit.cover,
//        ),
//      ),
//    );
//  }
//}

class MyCustomListView extends StatelessWidget {
  final OrdersList ordersList;

  MyCustomListView({this.ordersList, this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
    );
  }
}



