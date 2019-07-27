import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


import 'package:stock_app/models/orders_list_items.dart';
class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String orderTable = 'order_table';
  String colId = 'id';
  String colOrderItemId = 'order_items';
  String colStatus = 'status';
  String colUserId = 'user_id';
  String colUpdatedAt = 'updated_at';
  String colCreatedAt = 'created_at';
  String colPriority = 'id';


  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.


    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'order_table.db');

    // Open/create the database at a given path
    var ordersDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return ordersDatabase;
  }

  // Fetch Operation: Get all note objects from database

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $orderTable($colId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, $colStatus TEXT, '
        '$colCreatedAt TEXT, $colUpdatedAt, $colUserId INTEGER)');
  }
  Future<List<Map<String, dynamic>>> getOrderMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(orderTable, orderBy: '$colPriority ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertOrder(Order order) async {
    Database db = await this.database;
    var result = await db.insert(orderTable, order.toJson());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Order order) async {
    var db = await this.database;
    var result = await db.update(orderTable, order.toJson(), where: '$colId = ?', whereArgs: [order.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $orderTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $orderTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Order>> getOrderList() async {

    var orderMapList = await getOrderMapList(); // Get 'Map List' from database
    int count = orderMapList.length;         // Count the number of map entries in db table

    List<Order> orderList = List<Order>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      orderList.add(Order.fromJson(orderMapList[i]));
    }

    return orderList;
  }

}