import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/orders_list_items.dart';
import 'dart:io';

import 'file_service.dart';

Future<OrdersList> getOrdersList({String token}) async {
    final url = "https://inventory.azaronline.com/public/api/orders";
  print("seending get request");
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        'Authorization': 'bearer $token',
      },
    );
  print("after get request");
//  response.statusCode <= 401 || response.statusCode >= 200
  if (response.statusCode <= 401 || response.statusCode >= 200) {
    print("response : ${response.body}");

     print(response.body);
    // var o = OrdersList.fromJson(jsonDecode(response.body));

    // saving file
    JsonStorage jsonStorage = JsonStorage();
    await jsonStorage.writeJsonFile(response.body);


    OrdersList ordersList = ordersListFromJson(response.body);
//    print(ordersList.orders.first);
    return ordersList;
  }
  throw Exception("faild to load api");
}

Future<String> getUserImage(String token) async {
  final url = "https://inventory.azaronline.com/public/api/profile";
  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'bearer $token'
  });
//  final jsonResposen = json.decode(response.body);
  if (response.statusCode <= 401 || response.statusCode >= 200) {
    print("ok");
    print(response.body.toString());
    return response.body;
  } else {
    throw Exception("fial to get image form api");
  }
}

Future<String> createOrder({List<Map> body, String token}) async{
  print("this is map : $body");
  final url = "https://inventory.azaronline.com/public/api/orders/create";

    final response = await http.post(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });

  print("status code : ${response.statusCode}");
  print(response.body);
  if(response.statusCode == 201) {
    print(response.body);
    print("status code : ${response.statusCode}");
//    return response.body;
    return response.body;
  }


  throw Exception("faild to create order");

}
