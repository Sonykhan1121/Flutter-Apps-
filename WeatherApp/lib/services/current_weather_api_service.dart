import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/current_weather.dart';

class CurrentWeatherApiService {
  final String apiKey = "2ba67f4b323b7476e7fea6f007a2f4ad";

  Future<CurrentWeather> fetchCurrentWeather(double lat, double lon) async {
    final uri = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return CurrentWeather.fromJson(jsonResponse);
    } else {
      print("Failed to fetch weather. Status code: ${response.statusCode}. Response: ${response.body}");
      throw Exception('Current weather data API problem - Status Code: ${response.statusCode}');
    }
  }
}
