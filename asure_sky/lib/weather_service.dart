import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = '43e1f492e74bf5a45a5a5b58a89b1ac0';
  static const String _baseUrlCurrent = 'https://api.openweathermap.org/data/2.5/weather';

  static Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final url = '$_baseUrlCurrent?lat=$lat&lon=$lon&appid=$_apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error fetching current weather: ${response.statusCode}');
      throw Exception('Failed to load current weather data');
    }
  }
}
