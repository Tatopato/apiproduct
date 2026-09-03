import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getProducts() async {
    final url = Uri.parse('$baseUrl/products');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List products = data['products'];

      return products
          .map((json) => Product.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}