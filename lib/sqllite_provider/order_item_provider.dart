import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stock_app/models/orders_list_items.dart';

class OrderItemProvider {
  Database db;
  String _tableOrderItem = 'order_item_table';

  String _colId = 'id';
  String _colOrderId = 'order_id';
  String _colProductId = 'product_id';
  String _colQty = 'qty';
  String _colOrderItemStatus = 'status';
  String _colComment = 'comment';
  String _colCreatedAt = 'created_at';
  String _colUpdatedAt = 'updated_at';

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'stock.db');
    String createTableQuery =
        "CREATE TABLE $_tableOrderItem($_colId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, $_colOrderItemStatus TEXT, $_colCreatedAt TEXT, $_colComment TEXT, $_colUpdatedAt, $_colOrderId INTEGER, $_colProductId INTEGER, $_colQty INTEGER)";



    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(createTableQuery);
    });

  }

  Future createDb() async{
    await db.transaction((tnx) async {
      String createTableQuery =
          "CREATE TABLE $_tableOrderItem($_colId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, $_colOrderItemStatus TEXT, $_colCreatedAt TEXT, $_colComment TEXT, $_colUpdatedAt, $_colOrderId INTEGER, $_colProductId INTEGER, $_colQty INTEGER)";


      await tnx.execute(createTableQuery);
    });

  }


  Future<OrderItem> insert(OrderItem orderItem) async {
    orderItem.id = await db.insert(_tableOrderItem, orderItem.toMap());
    return orderItem;
  }

  Future<void> insertOrderItems(List<OrderItem> orderItems) async {

    orderItems.forEach((OrderItem orderItem) async {
      print(orderItem);
      int id = await db.insert(_tableOrderItem, orderItem.toMap());
    });
  }

  Future<void> deleteOrderItemDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'stock.db');

    return await deleteDatabase(path);
  }



//   Future<OrderItem> getOrderItem(int id) async {
//     List<Map> maps = await db.query(_tableOrderItem,
//         where: '$_colId = ?',
//         whereArgs: [id]);
//     if (maps.length > 0) {
//       return OrderItem.fromMap(maps.first);
//     }
// //    throw Exception("null");
//     return null;
//   }

  // Future<List<OrderItem>> getAllOrderItems() async {
  //   List<OrderItem> orderItems = List();
  //   List<Map> jsonOrders = await db.query(_tableOrderItem);

  //   jsonOrders.forEach((orderItem){
  //     orderItems.add(OrderItem.fromMap(orderItem));
  //   });

  //   return orderItems;
  // }

  Future<int> deleteOrderItem(int id) async {
    return await db.delete(_tableOrderItem, where: '$_colId = ?', whereArgs: [id]);
  }




  Future close() async => db.close();
}
