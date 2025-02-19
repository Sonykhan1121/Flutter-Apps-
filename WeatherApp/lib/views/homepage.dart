import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/views/current_weather_screen.dart';

import '../providers/themeprovider.dart';
class Homepage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<Homepage> {
  final TextEditingController _cityController = TextEditingController();

  void _navigateToWeatherDetails() {
    // Placeholder for navigation logic
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurrentWeatherScreen(city: _cityController.text.toLowerCase())),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Your Weather',style: themeProvider.themeData.textTheme.displayLarge,),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter your city name to get the latest weather updates.',
                textAlign: TextAlign.center,
                style:  themeProvider.themeData.textTheme.bodyLarge,
              ),
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset("assets/images/weather_banner.png"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: 'Enter your city here',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.location_city),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToWeatherDetails,
                child: Text('Get Weather',style: themeProvider.themeData.textTheme.bodyLarge),
                style: ElevatedButton.styleFrom(

                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}