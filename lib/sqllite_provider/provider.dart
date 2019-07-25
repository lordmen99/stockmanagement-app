import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Provider {
  Database db;


  Future open({String dbName : 'stock.db'}) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
              create table Products ( 
              id integer primary key autoincrement, 
              title text not null) ''');
    });


  }
  Future close() async => db.close();
}
