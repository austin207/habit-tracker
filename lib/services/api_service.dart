import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class ApiService {
  // Using a free weather API (no key required for demo)
  static const String _weatherBaseUrl = 'https://api.open-meteo.com/v1/forecast';

  // Get Weather Data (Open-Meteo API - no key required)
  static Future<Map<String, dynamic>?> getWeather(String city) async {
    try {
      // For demo, using fixed coordinates (can add geocoding later)
      // These are coordinates for New York
      final response = await http.get(
        Uri.parse('$_weatherBaseUrl?latitude=40.7128&longitude=-74.0060&current_weather=true'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'city': city,
          'temperature': data['current_weather']['temperature'],
          'description': _getWeatherDescription(data['current_weather']['weathercode']),
        };
      }
      return null;
    } catch (e) {
      print('Error fetching weather: $e');
      return null;
    }
  }

  static String _getWeatherDescription(int code) {
    if (code == 0) return 'Clear sky';
    if (code <= 3) return 'Partly cloudy';
    if (code <= 48) return 'Foggy';
    if (code <= 67) return 'Rainy';
    if (code <= 77) return 'Snowy';
    return 'Stormy';
  }

  // Get Motivational Quote
  static Future<String> getMotivationalQuote() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['title'] ?? 'Stay consistent with your habits!';
      }
      return 'Stay consistent with your habits!';
    } catch (e) {
      return 'Stay consistent with your habits!';
    }
  }
}
