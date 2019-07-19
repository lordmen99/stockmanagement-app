import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/orders_list.dart';
import 'dart:io';

Future<OrdersList> getOrdersList({String token}) async {
  final url = "http://localhost:8000/api/orders";
  print("seending get request");
  final response = await http.get(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      'Authorization' : 'bearer $token',
    },
  );
  
  if (response.statusCode <= 401 || response.statusCode >= 200) {
    
    // print(response.body);
    // var o = OrdersList.fromJson(jsonDecode(response.body));
    
    OrdersList ordersList = ordersListFromJson(response.body);
    
    return ordersList;
  }
    throw Exception("faild to load api");
}
