import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AuthService {
  static Future<Map> sendLoginRequest({Map body}) async {
    final response = await http.post("http://localhost:8000/api/auth/login",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(body));
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      print(response.body);
      final responseJson = jsonDecode(response.body);
      return responseJson;
    }
    throw Exception("faild to load api");
  }

  static Future<Map> sendRegisterRequest({Map body}) async {
    final response = await http.post("http://localhost:8000/api/auth/register",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(body));

    if (response.statusCode <= 401 || response.statusCode >= 200) {
      final responseJson = jsonDecode(response.body);
      return responseJson;
    }
    
    throw Exception("faild to load api");
  }
}
