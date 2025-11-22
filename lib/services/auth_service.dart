import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _userKey = 'current_user';
  static const String _isLoggedInKey = 'is_logged_in';

  // Sign Up
  static Future<Map<String, dynamic>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Validate email
      if (!email.contains('@')) {
        return {'success': false, 'message': 'Invalid email format'};
      }

      // Validate password
      if (password.length < 6) {
        return {'success': false, 'message': 'Password must be at least 6 characters'};
      }

      // Validate username
      if (username.length < 3) {
        return {'success': false, 'message': 'Username must be at least 3 characters'};
      }

      // Create user
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: username,
        email: email,
      );

      // Save user
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(user.toJson()));
      await prefs.setBool(_isLoggedInKey, true);

      return {'success': true, 'user': user};
    } catch (e) {
      return {'success': false, 'message': 'Sign up failed: ${e.toString()}'};
    }
  }

  // Login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Validate credentials
      if (!email.contains('@')) {
        return {'success': false, 'message': 'Invalid email format'};
      }

      if (password.length < 6) {
        return {'success': false, 'message': 'Password must be at least 6 characters'};
      }

      // Mock user data
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: email.split('@')[0],
        email: email,
      );

      // Save session
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(user.toJson()));
      await prefs.setBool(_isLoggedInKey, true);

      return {'success': true, 'user': user};
    } catch (e) {
      return {'success': false, 'message': 'Login failed: ${e.toString()}'};
    }
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Check if logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get current user
  static Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}
