import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/widgets/weather_page.dart';
import 'package:weather_app/widgets/weather_update_unavailable.dart';
import '../providers/current_weather_provider.dart';

class CurrentWeatherScreen extends StatefulWidget {
  final String city;

  CurrentWeatherScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<CurrentWeatherProvider>(
      context,
      listen: false,
    ).loadWeather(city: widget.city);

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in ${widget.city}'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child:
            isLoading
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Loading...'),
                    SizedBox(height: 30),
                    CircularProgressIndicator(),
                  ],
                )
                : Consumer<CurrentWeatherProvider>(
                  builder: (context, weatherProvider, child) {
                    // Load weather data if not already loaded
                    if (weatherProvider.currentWeather == null) {
                      return WeatherUpdateUnavailableWidget();
                    }

                    return WeatherPage();
                  },
                ),
      ),
    );
  }
}
