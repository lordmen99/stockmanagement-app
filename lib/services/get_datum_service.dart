import 'dart:convert';
import '../models/datum_model.dart';
import 'package:http/http.dart' as http;


Future<Datum> getDatum() async{
  final url = "http://10.0.2.2:8000/api/categories";
  var response = await http.get(url,headers: {
    'Content-Type' : 'application/json',
    'Accept' : 'application/json'
  });
  if(response.statusCode == 200){
    Datum datum = datumFromJson(response.body);
    return datum;
  }

  throw Exception("fiald to get data from api");

}