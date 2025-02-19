import 'package:flutter/material.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/services/current_weather_api_service.dart';

class CurrentWeatherProvider with ChangeNotifier{

  CurrentWeatherModel? _currentWeather;
  final CurrentWeatherApiService _apiService = CurrentWeatherApiService();

  CurrentWeatherModel? get currentWeather => _currentWeather;

  Future<void> loadWeather({required String city}) async{
    _currentWeather = await _apiService.fetchCurrentWeather(city);
    notifyListeners();
  }
}