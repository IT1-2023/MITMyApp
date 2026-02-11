import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'auth_service.dart';

class WishlistService {
  static const _baseUrl = "http://10.0.2.2:5000/api/wishlist";

  static Future<Map<String, String>> _authHeaders() async {
    final token = await AuthService.getToken();
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // GET WISHLIST (AUTH)
  static Future<List<Product>> getWishlist() async {
    final headers = await _authHeaders();

    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      
      final items = data["items"] ?? [];
      return (items as List).map((p) => Product.fromJson(p)).toList();
    } else {
      throw Exception("Failed to load wishlist");
    }
  }

  // TOGGLE/ADD PRODUCT (AUTH)
  static Future<List<Product>> toggleWishlist(String productId) async {
    final headers = await _authHeaders();

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: jsonEncode({"productId": productId}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final items = data["items"] ?? [];
      return (items as List).map((p) => Product.fromJson(p)).toList();
    } else {
      throw Exception("Failed to update wishlist");
    }
  }

  // REMOVE PRODUCT (AUTH)
  static Future<List<Product>> removeFromWishlist(String productId) async {
    final headers = await _authHeaders();

    final response = await http.delete(
      Uri.parse("$_baseUrl/$productId"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final items = data["items"] ?? [];
      return (items as List).map((p) => Product.fromJson(p)).toList();
    } else {
      throw Exception("Failed to remove from wishlist");
    }
  }
}
