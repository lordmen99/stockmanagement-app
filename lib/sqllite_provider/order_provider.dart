import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stock_app/models/orders_list_items.dart';


class OrderProvider{
  Database db;
  String _tableOrder = 'order_table';

  String _colId = 'id';
  String _colUserId = 'user_id';
  String _colOrderStatus = 'status';
  String _colCreatedAt = 'created_at';
  String _colUpdatedAt = 'updated_at';


  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'stock.db');
    String createTableQuery  = "CREATE TABLE $_tableOrder($_colId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, $_colOrderStatus TEXT, $_colCreatedAt TEXT, $_colUpdatedAt, $_colUserId INTEGER)" ;

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(createTableQuery);
        });
  }

  Future<Order> insert(Order order) async {
    order.id = await db.insert(_tableOrder, order.toJson());
    return order;
  }

  Future<void> insertOrders(List<Order> orders) async {
    orders.forEach((Order order) async {
      int id = await db.insert(_tableOrder, order.toJson());
      print(id);
    });
  }

  Future<void> deleteOrderDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    return await deleteDatabase(path);
  }



  Future<Order> getOrder(int id) async {
    List<Map> maps = await db.query(_tableOrder,
        columns: [_colId, _colOrderStatus, _colUserId, _colCreatedAt, _colUpdatedAt],
        where: '$_colId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Order.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Order>> getAllOrders() async {
    List<Order> orders = List();
    List<Map> jsonOrders = await db.query(_tableOrder);

    jsonOrders.forEach((order){
      orders.add(Order.fromJson(order));
    });

    return orders;
  }

  Future<int> deleteOrder(int id) async {
    return await db.delete(_tableOrder, where: '$_colId = ?', whereArgs: [id]);
  }


  Future close() async => db.close();


}