import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'auth_service.dart';

class ApiService {
  static const baseUrl = "http://10.0.2.2:5000/api";

  static String _apiHost() {
    return baseUrl.endsWith('/api')
        ? baseUrl.substring(0, baseUrl.length - 4)
        : baseUrl;
  }

  
  static String resolveImagePath(String rawPath) {
    final trimmed = rawPath.trim();
    if (trimmed.isEmpty) return '';

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      final uri = Uri.tryParse(trimmed);
      if (uri == null) return trimmed;

      final host = uri.host.toLowerCase();
      if (host == 'localhost' || host == '127.0.0.1') {
        return uri.replace(host: '10.0.2.2').toString();
      }

      return trimmed;
    }

    if (trimmed.startsWith('/')) {
      return '${_apiHost()}$trimmed';
    }

    if (trimmed.startsWith('uploads/')) {
      return '${_apiHost()}/$trimmed';
    }

    return trimmed;
  }

  //AUTH HEADERS 
  static Future<Map<String, String>> _authHeaders() async {
    final token = await AuthService.getToken();

    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  //IMAGE UPLOAD 
  static Future<String> uploadProductImage(File imageFile) async {
    final token = await AuthService.getToken();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/products/upload'),
    );

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.files.add(
      await http.MultipartFile.fromPath('image', imageFile.path),
    );

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['imageUrl'] ?? '').toString();
    }

    throw Exception('Failed to upload image');
  }

  //GET ALL PRODUCTS 
  static Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse("$baseUrl/products"),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((p) => Product.fromJson(p)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  // CREATE PRODUCT 
  static Future<Product> createProduct(Product product) async {
    final headers = await _authHeaders();

    final response = await http.post(
      Uri.parse("$baseUrl/products"),
      headers: headers,
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create product");
    }
  }

  // UPDATE PRODUCT
  static Future<Product> updateProduct(Product product) async {
    final headers = await _authHeaders();

    final response = await http.put(
      Uri.parse("$baseUrl/products/${product.id}"),
      headers: headers,
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update product");
    }
  }

  // DELETE PRODUCT 
  static Future<void> deleteProduct(String id) async {
    final headers = await _authHeaders();

    final response = await http.delete(
      Uri.parse("$baseUrl/products/$id"),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete product");
    }
  }

  //RATE PRODUCT 
  static Future<Product> rateProduct(String id, int rating) async {
    final headers = await _authHeaders();

    final response = await http.post(
      Uri.parse("$baseUrl/products/$id/rate"),
      headers: headers,
      body: jsonEncode({"rating": rating}),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to rate product");
    }
  }
}
