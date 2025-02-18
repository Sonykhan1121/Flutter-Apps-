import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/current_weather_provider.dart';
import 'package:weather_app/views/current_weather_screen.dart';
import 'package:weather_app/views/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentWeatherProvider()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  CurrentWeatherScreen(lat: 23.8103,lon: 90.4125), // Set HomeScreen as the home
      ),
    );
  }
}
