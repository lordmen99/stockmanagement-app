import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AuthService {
  static Future<Map> sendLoginRequest({Map body}) async {
    final response = await http.post("http://10.0.2.2:8000/api/auth/login",
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(body));

    final responseJson = jsonDecode(response.body);
    return responseJson;
  }

}
