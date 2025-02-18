import 'package:flutter/material.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/services/current_weather_api_service.dart';

class CurrentWeatherProvider with ChangeNotifier{

  CurrentWeather? _currentWeather;
  final CurrentWeatherApiService _apiService = CurrentWeatherApiService();

  CurrentWeather? get currentWeather => _currentWeather;

  Future<void> loadWeather(double lat, double lon) async{
    _currentWeather = await _apiService.fetchCurrentWeather(lat,lon);
    notifyListeners();
  }
}