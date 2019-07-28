import 'package:stock_app/models/orders_list_items.dart';
import 'package:stock_app/sqllite_provider/provider.dart';

class OrderListProvider extends Provider{
  String _tableName = 'order_list';

  Future insert(Order order) async {
    return await db.insert(_tableName, order.toJson());
  }


}