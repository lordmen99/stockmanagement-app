import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as prefix0;
import 'package:stock_app/models/orders_list_items.dart';

class NewSqlProvider {
  Database database;
  String _tableName = 'order_table';
  String _order_item_table = 'order_item_table';
  Future<Database> getDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'stock.db');

    String sql = '''
    CREATE TABLE $_tableName (
      order_id INTEGER PRYMARY KEY,
      user_id INTEGER,
      order_status TEXT,
      created_at TEXT,
      updated_at TEXT
    )
    ''';

    String sql2 = '''
      CREATE TABLE $_order_item_table (
        order_item_id INTEGER PRYMARY KEY,
        order_id INTEGER,
        product_id INTEGER,
        qty INTEGER,
        order_item_status TEXT,
        comment TEXT,
        order_item_created_at TEXT,
        order_item_updated_at TEXT
      )
    ''';
    this.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(sql);
      await db.execute(sql2);
    });

    return database;
  }

  Future<void> insertOrder(Order order) async {
    await getDatabase();
    int id = await database.insert(_tableName, order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
        await database.insert(_order_item_table, order.orderItems.first.toMap());
    print(id);
  }

  Future<void> deleteMyDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'stock.db');
    await deleteDatabase(path);
  }

  Future<List<Map>> getOrder() async {
    await getDatabase();
    // List<Map<String, dynamic>> maps = await database.query(_order_item_table);
    String sql = "SELECT * FROM $_tableName INNER JOIN $_order_item_table ON $_tableName.order_id = $_order_item_table.order_id";
    List<Map> maps = await database.rawQuery(sql);
    return maps;
  }
}
