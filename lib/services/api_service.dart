import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3001/api';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Get stored token
  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Store token
  static Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  // Remove token
  static Future<void> removeToken() async {
    await _storage.delete(key: 'auth_token');
  }

  // Register user
  static Future<Map<String, dynamic>> register(String phoneNumber, String mpin) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'mpin': mpin,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201) {
        await storeToken(data['token']);
        return data;
      } else {
        throw Exception(data['error'] ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Login user
  static Future<Map<String, dynamic>> login(String phoneNumber, String mpin) async {
    try {
      print('Attempting to login with phone: $phoneNumber');
      
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'mpin': mpin,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        await storeToken(data['token']);
        return data;
      } else {
        throw Exception(data['error'] ?? 'Login failed');
      }
    } catch (e) {
      print('Login error: $e');
      if (e.toString().contains('SocketException') || e.toString().contains('Connection refused')) {
        throw Exception('Cannot connect to server. Please make sure the backend is running on port 3001.');
      }
      throw Exception('Network error: $e');
    }
  }

  // Get user profile
  static Future<User> getProfile() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No authentication token');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return User.fromJson(data['user']);
      } else {
        throw Exception(data['error'] ?? 'Failed to get profile');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Get transactions
  static Future<List<Transaction>> getTransactions() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No authentication token');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/transactions'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return (data['transactions'] as List)
            .map((transaction) => Transaction.fromJson(transaction))
            .toList();
      } else {
        throw Exception(data['error'] ?? 'Failed to get transactions');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Send money
  static Future<Map<String, dynamic>> sendMoney(String recipient, double amount, String description) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No authentication token');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/send-money'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'recipient': recipient,
          'amount': amount,
          'description': description,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return data;
      } else {
        throw Exception(data['error'] ?? 'Failed to send money');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Update balance
  static Future<double> updateBalance(double balance) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No authentication token');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/balance'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'balance': balance,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return data['balance'];
      } else {
        throw Exception(data['error'] ?? 'Failed to update balance');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Logout
  static Future<void> logout() async {
    await removeToken();
  }
} 