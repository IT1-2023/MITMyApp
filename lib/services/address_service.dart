import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_address.dart';
import 'auth_service.dart';

class AddressService {
  static const _baseUrl = "http://10.0.2.2:5000/api/address";

  static Future<Map<String, String>> _authHeaders() async {
    final token = await AuthService.getToken();
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // GET MY ADDRESS (AUTH)
  static Future<UserAddress?> getAddress() async {
    final headers = await _authHeaders();

    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      if (response.body.isEmpty) return null;
      final data = jsonDecode(response.body);
      if (data == null) return null;
      return UserAddress.fromJson(data);
    } else {
      throw Exception("Failed to load address");
    }
  }

  // UPDATE MY ADDRESS (AUTH)
  static Future<UserAddress> updateAddress(UserAddress newAddress) async {
    final headers = await _authHeaders();

    final response = await http.put(
      Uri.parse(_baseUrl),
      headers: headers,
      body: jsonEncode(newAddress.toJson()),
    );

    if (response.statusCode == 200) {
      return UserAddress.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update address");
    }
  }
}
