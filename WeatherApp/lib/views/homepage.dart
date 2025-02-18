import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/current_weather_provider.dart';

class WeatherScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const WeatherScreen({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var weatherProvider = Provider.of<CurrentWeatherProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in Your Area'),
      ),
      body: Center(
        child: weatherProvider.currentWeather != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Temperature: ${weatherProvider.currentWeather!.temperature}°C'),
            Text('Feels Like: ${weatherProvider.currentWeather!.feelsLike}°C'),
            Text('Humidity: ${weatherProvider.currentWeather!.humidity}%'),
            Text('Wind Speed: ${weatherProvider.currentWeather!.windSpeed} m/s'),
            Text('Description: ${weatherProvider.currentWeather!.description}'),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
