import 'package:stock_app/sqllite_provider/provider.dart';

class ProductProvider extends Provider{
  String _tableName = 'products';

  Future insert() async {

    return await db.insert(_tableName, Map.from({"title" : "this is a product titlte"}));
  }
}


