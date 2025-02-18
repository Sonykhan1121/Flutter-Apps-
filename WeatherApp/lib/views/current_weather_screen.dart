import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/current_weather_provider.dart';


class CurrentWeatherScreen extends StatelessWidget {
  final double lat;
  final double lon;

  CurrentWeatherScreen({Key? key, required this.lat, required this.lon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in $lat and $lon'),
      ),
      body: Center(
        child: Consumer<CurrentWeatherProvider>(
          builder: (context, weatherProvider, child) {
            // Load weather data if not already loaded
            if (weatherProvider.currentWeather == null) {
              weatherProvider.loadWeather(lat,lon);
              return const CircularProgressIndicator();
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Temperature: ${weatherProvider.currentWeather!.temperature}°C'),
                Text('Feels Like: ${weatherProvider.currentWeather!.feelsLike}°C'),
                Text('Humidity: ${weatherProvider.currentWeather!.humidity}%'),
                Text('Wind Speed: ${weatherProvider.currentWeather!.windSpeed} m/s'),
                Text('Description: ${weatherProvider.currentWeather!.description}'),
              ],

            );
          },
        ),
      ),
    );
  }
}
