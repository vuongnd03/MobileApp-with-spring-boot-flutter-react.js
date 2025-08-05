import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app_ecommerce/features/products/product.dart';

class ProductService {
  static const String _baseUrl =
      'http://192.168.1.6:8282/api/product/allProduct';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
