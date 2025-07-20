import 'dart:convert';
import 'package:http/http.dart' as http;

class HourlyWeatherService {
  static const String _apiKey = '43e1f492e74bf5a45a5a5b58a89b1ac0';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  static Future<List<Map<String, dynamic>>> fetchHourlyForecast(double lat, double lon) async {
    final response = await http.get(Uri.parse(
      '$_baseUrl?lat=$lat&lon=$lon&exclude=current,minutely,daily,alerts&appid=$_apiKey&units=metric',
    ));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (!data.containsKey('hourly')) {
        throw Exception('No hourly data found');
      }

      final List<dynamic> hourly = data['hourly'];
      return hourly.take(12).map((h) => h as Map<String, dynamic>).toList();
    } else {
      print('API Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load hourly forecast');
    }
  }
}
