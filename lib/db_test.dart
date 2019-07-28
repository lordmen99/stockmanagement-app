import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_app/sqllite_provider/order_item_provider.dart';
import './sqllite_provider/b_util.dart';
import 'models/orders_list_items.dart';
import './sqllite_provider/order_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
//  Future<void> saveOrder() async {
//    Order order = new Order(
//      id: 1,
//      createdAt: DateTime.parse("2019-06-26 06:36:49"),
//      updatedAt: DateTime.parse("2019-06-26 06:36:49"),
//      orderItems: [],
//      status: OrderStatus.OPEN,
//      userId: 1
//    );
//
//
//    var db_helper  = DatabaseHelper();
//    await db_helper.initializeDatabase();
////    int id = await db_helper.insertOrder(order);
////    print(id.toString());
//      List<Map> orders = await db_helper.getOrderMapList();
//
//      print(orders);
//
//
//
//
//  }

  saveOrderInDb() async {
    OrderProvider orderDb = new OrderProvider();
    await orderDb.open();

    Order order1 = new Order(
        id: 1,
        createdAt: DateTime.parse("2019-06-26 06:36:49"),
        updatedAt: DateTime.parse("2019-06-26 06:36:49"),
        orderItems: [],
        status: OrderStatus.OPEN,
        userId: 1);
    Order order2 = new Order(
        id: 2,
        createdAt: DateTime.parse("2019-06-26 06:36:49"),
        updatedAt: DateTime.parse("2019-06-26 06:36:49"),
        orderItems: [],
        status: OrderStatus.OPEN,
        userId: 1);

    await orderDb.insertOrders([order1, order2]);

//    orderDb.insert(order);

//    order = await orderDb.getOrder(1);
//    print(order.status.toString());
  }

  saveOrderItemInDb() async{
    OrderItem orderItem1 = new OrderItem(
      status: OrderItemStatus.APPROVED,
      createdAt: DateTime.parse("2019-06-26 06:36:49"),
      updatedAt: DateTime.parse("2019-06-26 06:36:49"),
      id: 1,
      qty: 12,
      productId: 3,
      comment: "hello",
      orderId: 1,
      product: null,
    );
    OrderItem orderItem2 = new OrderItem(
      status: OrderItemStatus.CANCELED,
      createdAt: DateTime.parse("2019-06-26 06:36:49"),
      updatedAt: DateTime.parse("2019-06-26 06:36:49"),
      id: 2,
      qty: 1100,
      productId: 12,
      comment: "godbye",
      orderId: 2,
      product: null,
    );

    OrderItemProvider orderItemProvider = new OrderItemProvider();
    await orderItemProvider.open();
    orderItemProvider.createDb();
    await orderItemProvider.insertOrderItems([orderItem1, orderItem2]);


  }

  getAllOrders() async {
    OrderProvider orderDb = new OrderProvider();
    await orderDb.open();

    List<Order> orders = await orderDb.getAllOrders();
    print(orders.length);
    print(orders.first.toString());
  }

  // getAllOrderItems() async {
  //   OrderItemProvider orderItemProvider = new OrderItemProvider();
  //   await orderItemProvider.open();
  //   List<OrderItem> orderitems = await orderItemProvider.getAllOrderItems();

  //   print(orderitems.length);
  //   print(orderitems.first.toString());

  // }

  deletedd() async {
    print("deleting");
    OrderItemProvider orderItemProvider = new OrderItemProvider();

    orderItemProvider.deleteOrderItemDatabase();

  }


  myQuery() async {
    OrderProvider orderDb = new OrderProvider();
    await orderDb.open();
//    String sql = 'SELECT order_table.*,order_item_table.status as orderItemStatus,  FROM order_table '+
//    'INNER JOIN order_item_table '+
//    'ON order_table.id = order_item_table.order_id';

  String ssql = '''
    SELECT order_table.*, order_item_table.* FROM order_table LEFT OUTER JOIN order_item_table ON order_table.id = order_item_table.order_id WHERE (order_table.id = 2)
  ''';

//    sql = "select * from order_item_table";

    List myList = await orderDb.db.rawQuery(ssql);

    print(myList.first);
  }

  @override
  void initState() {

//    deletedd();
//    saveOrderInDb();
    saveOrderItemInDb();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                getAllOrders();
              },
              child: Text("get orders from db"),
            ),
            RaisedButton(
              child: Text("save orders"),
              onPressed: () {
                saveOrderInDb();
              },
            ),
            RaisedButton(
              child: Text("get order items"),
              onPressed: (){
                // getAllOrderItems();
              },
            ),
            RaisedButton(
              child: Text("raw query"),
              onPressed: (){
                myQuery();
              },
            ),
          ],
        ),
      ),
    );
  }
}
