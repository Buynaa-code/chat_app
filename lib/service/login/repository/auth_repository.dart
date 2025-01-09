import 'dart:convert';
import 'package:chat_app/service/login/model/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = 'http://localhost:5001'; // Update for the emulator

  // Register user
  Future<String> register(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return 'User registered successfully!';
    } else {
      final errorResponse = json.decode(response.body);
      return errorResponse['message'];
    }
  }

  // Login user
  Future<LoginResponse> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return LoginResponse.fromJson(data);
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['message']);
    }
  }

  // Validate token (for example, in protected routes)
  Future<String> validateToken(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/validate'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['message']);
    }
  }
}
