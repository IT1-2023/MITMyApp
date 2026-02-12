import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order.dart';
import '../models/cart_item.dart';
import 'auth_service.dart';

class OrderService {
  static const _baseUrl = "http://10.0.2.2:5000/api/orders";

  static Future<Map<String, String>> _authHeaders() async {
    final token = await AuthService.getToken();
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // CREATE ORDER (AUTH)
  static Future<Order> createOrder({
    required List<CartItem> items,
    required double totalPrice,
  }) async {
    final user = AuthService.currentUser;
    if (user == null) {
      throw Exception("Not logged in");
    }

    final headers = await _authHeaders();

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: jsonEncode({
        "customerName": user.name,
        "items": items.map((i) => i.toJson()).toList(),
        "totalPrice": totalPrice,
        "status": "Pending",
        "date": DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create order");
    }
  }

  // GET MY ORDERS (AUTH)
  static Future<List<Order>> getMyOrders() async {
    final headers = await _authHeaders();

    final response = await http.get(
      Uri.parse("$_baseUrl/my"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((o) => Order.fromJson(o)).toList();
    } else {
      throw Exception("Failed to load my orders");
    }
  }

  // GET ALL ORDERS (ADMIN)
  static Future<List<Order>> getAllOrders() async {
    final headers = await _authHeaders();

    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((o) => Order.fromJson(o)).toList();
    } else {
      throw Exception("Failed to load orders");
    }
  }

  // UPDATE STATUS (ADMIN)
  static Future<Order> updateStatus(String orderId, String status) async {
    final headers = await _authHeaders();

    final response = await http.put(
      Uri.parse("$_baseUrl/$orderId/status"),
      headers: headers,
      body: jsonEncode({"status": status}),
    );

    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update order status");
    }
  }
}
