import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stock_app/models/orders_list_items.dart' as model;
import 'package:stock_app/pages/order_items_page/orders_list_items_page.dart';

import 'package:stock_app/services/api_services.dart';
import 'package:stock_app/services/check_internet_connection_service.dart';
import 'package:stock_app/services/file_service.dart';
import 'package:stock_app/theme/style.dart';
import 'components/components.dart';

class OrdersPage extends StatefulWidget {
  final String token;


  OrdersPage({this.token});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
//    Future<model.OrdersList> _ordersList = getOrdersList(token: this.token);

    Future<model.OrdersList> getOrdersFromFile() async {
      if(await checkNetworkConnection(context)){
        print("first");
        return await getOrdersList(token: widget.token);

      }else{
        print("secound");
        JsonStorage jsonStorage = JsonStorage();
        return model.ordersListFromJson(await jsonStorage.readJsonFile());
      }
    }

    return Scaffold(
        backgroundColor: mainColor,
        body: FutureBuilder<model.OrdersList>(
          future:  getOrdersFromFile(),
          builder: (context, AsyncSnapshot  snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                header: defaultHeader,
                onRefresh: ()  {



                  _refreshController.refreshCompleted();
                  setState(() {

                  });
                },
                child: CustomScrollView(
                  slivers: <Widget>[
                    RefreshBackground(),
                    SliverList(delegate: SliverChildListDelegate([
                      Container(
                        margin: EdgeInsets.only(top: 50),
                          child :Center(child: Text("Cannot to access the serve...", style: TextStyle(color: Colors.white, fontSize: 24),))),
                    ])),
                  ],
                ),
              );
            }
//            if(snapshot.connectionState == ConnectionState.waiting){
//              return CircularProgressIndicator();
//            }

            model.OrdersList ordersList = snapshot.data;
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              header: defaultHeader,
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
                print("fgfgf");
                _refreshController.refreshCompleted();
              },
              child: snapshot.hasData
                  ? CustomScrollView(
                      slivers: <Widget>[
                        RefreshBackground(),
                        SliverList(
                            delegate: SliverChildListDelegate(
                                List.generate(ordersList.orders.length, (index) {
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
                        }))),
                      ],
                    )
                  : snapshot.connectionState == ConnectionState.waiting ? Container( margin: EdgeInsets.only(top: 50),child: Center(child:  CircularProgressIndicator(),),): Text("faild to serve"),
            );
          },
        ));
  }
}
//
//List<Widget> buildList() {
//  return List.generate(
//      15,
//      (index) => Container(
//            height: 100,
//            margin: const EdgeInsets.symmetric(
//              vertical: 10,
//              horizontal: 15,
//            ),
//            decoration: BoxDecoration(
//              color: Colors.white,
//              borderRadius: BorderRadius.circular(15),
//            ),
//          ));
//}

//Column(
////mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Container(
//margin: EdgeInsets.only(top: 65, bottom: 20),
//child: Text(
//"List of Orders",
//style: TextStyle(color: Colors.white, fontSize: 23),
//),
//),
//FutureBuilder<OrdersList>(
//future: getOrdersList(token: this.token),
//builder: (context, snapshot) {
//if (snapshot.hasError) {
//
//print(snapshot.error.toString());
//return Text("Cannot to access the serve...");
//} else if (snapshot.hasData) {
//OrdersList ordersList = snapshot.data;
//if (ordersList.orders.isEmpty) {
//return Text(
//"List is Empty",
//style: TextStyle(color: Colors.green, fontSize: 19),
//);
//}
//return Expanded(
//child: MyCustomListView(ordersList: ordersList,),
//);
//}
//return CircularProgressIndicator();
//},
//),
//],
//),

class RefreshBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
          background: Image.network(
        "https://images.unsplash.com/photo-1541701494587-cb58502866ab?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=0c21b1ac3066ae4d354a3b2e0064c8be&auto=format&fit=crop&w=500&q=60",
        fit: BoxFit.cover,
      )),
    );
  }
}
