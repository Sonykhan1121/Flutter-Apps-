import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/current_weather_model.dart';

class CurrentWeatherApiService {
  final String apiKey = "a2a1941b852f4f408b922416251902";

  Future<CurrentWeatherModel> fetchCurrentWeather(String city) async {
    final uri = Uri.parse('https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return CurrentWeatherModel.fromJson(jsonResponse);
    } else {
      print("Failed to fetch weather. Status code: ${response.statusCode}. Response: ${response.body}");
      throw Exception('Current weather data API problem - Status Code: ${response.statusCode}');
    }
  }
}
