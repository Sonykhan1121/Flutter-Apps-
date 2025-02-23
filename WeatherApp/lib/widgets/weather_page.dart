import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/providers/current_weather_provider.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    final currentWeatherProvider = Provider.of<CurrentWeatherProvider>(context);
    final currentWeather = currentWeatherProvider.currentWeather;
    return Center(
      child: SingleChildScrollView(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Basic Information Section
              _buildBasicInfoSection(currentWeather),
              SizedBox(height: 24.0),
              // 2. Temperature Section
              _buildTemperatureSection(currentWeather),
              SizedBox(height: 24.0),
              // 3. Wind Section
              _buildWindSection(currentWeather),
              SizedBox(height: 24.0),
              // 4. Additional Details Section
              _buildAdditionalDetailsSection(currentWeather),
              SizedBox(height: 24.0),
              // 5. Precipitation Section
              _buildPrecipitationSection(currentWeather),
              SizedBox(height: 24.0),
              // 6. Dew Point and Cloud Coverage
              _buildDewPointAndCloudCoverageSection(currentWeather),
            ],
          ),
        ),
    );

  }

  Widget _buildBasicInfoSection(CurrentWeatherModel? currentWeather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, size: 40, color: Colors.blue), // Location icon
            SizedBox(width: 8.0),
            Text(
              '${currentWeather?.location.toString()}, Updated: ${currentWeather?.lastUpdated}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Image.network("http:${currentWeather?.conditionicon}", height: 48,width: 48, color: Colors.orange), // Sunny icon
            SizedBox(width: 8.0),
            Text(
              '${currentWeather?.conditiontext}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTemperatureSection(CurrentWeatherModel? currentWeather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.thermostat, size: 40, color: Colors.red), // Thermometer icon
            SizedBox(width: 8.0),
            Text(
              '${currentWeather?.tempC}°C | ${currentWeather?.tempF}°F',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Feels like ${currentWeather?.feelslikeC}°C | ${currentWeather?.feelslikeF}°F',
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildWindSection(CurrentWeatherModel? currentWeather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.air, size: 40, color: Colors.green), // Wind icon
            SizedBox(width: 8.0),
            Text(
              '${currentWeather?.windMph} mph ENE | ${currentWeather?.windKph} kph ENE',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Gusts up to ${currentWeather?.gustMph} mph | ${currentWeather?.gustKph} kph',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildAdditionalDetailsSection(CurrentWeatherModel? currentWeather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(Icons.opacity, 'Humidity: ${currentWeather?.humidity}%'), // Humidity icon
        SizedBox(height: 8.0),
        _buildDetailRow(Icons.speed, 'Pressure: ${currentWeather?.pressureMb} mb | ${currentWeather?.pressureIn} in'), // Pressure icon
        SizedBox(height: 8.0),
        _buildDetailRow(Icons.remove_red_eye, 'Visibility: ${currentWeather?.visKm} km | ${currentWeather?.visMiles} miles'), // Visibility icon
        SizedBox(height: 8.0),
        _buildDetailRow(Icons.wb_sunny, 'UV Index: ${currentWeather?.uv}'), // UV Index icon
      ],
    );
  }

  Widget _buildPrecipitationSection(CurrentWeatherModel? currentWeather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.cloud, size: 40, color: Colors.blueGrey), // Precipitation icon
            SizedBox(width: 8.0),
            Text(
              'Precipitation: 0.0 mm | 0.0 in',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDewPointAndCloudCoverageSection(CurrentWeatherModel? currentWeather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(Icons.cloud_queue, 'Dew Point: ${currentWeather?.dewpointC}°C | ${currentWeather?.dewpointF}°F'), // Dew Point icon
        SizedBox(height: 8.0),
        _buildDetailRow(Icons.cloud_circle, 'Cloud Coverage: ${currentWeather?.cloud}%'), // Cloud Coverage icon
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.grey), // Generic icon
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}