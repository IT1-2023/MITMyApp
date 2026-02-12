import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_user.dart';

class AuthService {

  static const _baseUrl = "http://10.0.2.2:5000/api/auth";

  static AppUser? currentUser;

  //================= LOGIN =================
  static Future<void> login(String email, String password) async {

    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(data.toString());
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", data["token"]);

    currentUser = AppUser(
      id: data["_id"],
      name: data["name"],
      email: data["email"],
      isAdmin: data["isAdmin"],
    );
  }

  //================= REGISTER =================
  static Future<void> register(
    String name,
    String email,
    String password,
  ) async {

    final response = await http.post(
      Uri.parse("$_baseUrl/register"), 
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode != 201) {
      String message = "Registration failed";
      try {
        final data = jsonDecode(response.body);
        if (data is String && data.trim().isNotEmpty) {
          message = data;
        } else if (data is Map && data["message"] != null) {
          message = data["message"].toString();
        }
      } catch (_) {
        
      }
      throw Exception(message);
    }

    // AUTO LOGIN POSLE REGISTRACIJE
    await login(email, password);
  }

  //================= AUTO LOGIN =================
  static Future<bool> tryAutoLogin() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) return false;

    final response = await http.get(
      Uri.parse("$_baseUrl/me"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      await prefs.remove("token");
      return false;
    }

    final data = jsonDecode(response.body);

    currentUser = AppUser(
      id: data["_id"],
      name: data["name"],
      email: data["email"],
      isAdmin: data["isAdmin"],
    );

    return true;
  }

  // ================= LOGOUT =================
  static Future<void> logout() async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");

    currentUser = null;
  }

  // ================= TOKEN =================
  static Future<String?> getToken() async {

    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static bool isLoggedIn() => currentUser != null;

  static bool isAdmin() => currentUser?.isAdmin == true;
}
