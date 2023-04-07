import 'dart:convert';

import 'package:demo51/screens/homePage/modal/home_modal.dart';
import 'package:http/http.dart' as http;

class ApiCall
{
  ApiCall._();
  static ApiCall apiCall =ApiCall._();
  Future<List<dynamic>?> productsApi() async
  {
      String? productapi = "https://fakestoreapi.com/products";
      var response =await http.get(Uri.parse(productapi));
      if(response.statusCode == 200)
        {
          var json = jsonDecode(response.body);
          // print(json);
          return json.map((e)=>Modal.fromJson(e)).toList();
        }
      else
        {
          return null;
        }

  }
}