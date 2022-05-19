import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_routes/api_routes.dart';
import '../model/NewsModel.dart';
import '../model/product_model.dart';

class GetProducts {
  static Future<List<ProductModel>?> getProductsData() async {
    var url = 'https://fakestoreapi.com/products';
    http.Response response = await http.get(
      Uri.parse(ApiRoutes.allProducts),
    );
    print("Response==>>${jsonDecode(response.body)}");

    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      return null;
    }
  }
}

class GetNews {
  static Future<NewsModel?> getNewsData() async {
    var url =
        "https://newsapi.org/v2/everything?q=tesla&from=2022-04-06&sortBy=publishedAt&apiKey=f4c915d71c6c40168cde0af9846d5289";
    http.Response response = await http.get(
      Uri.parse(url),
    );
    print("Response==>>${jsonDecode(response.body)}");

    if (response.statusCode == 200) {
      return newsModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
