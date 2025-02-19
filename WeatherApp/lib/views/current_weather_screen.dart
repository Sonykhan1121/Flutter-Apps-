import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/current_weather_provider.dart';

class CurrentWeatherScreen extends StatefulWidget {
  final String city;

   CurrentWeatherScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CurrentWeatherProvider>(context,listen: false).loadWeather(city: widget.city);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather in ${widget.city}'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Consumer<CurrentWeatherProvider>(
          builder: (context, weatherProvider, child) {
            // Load weather data if not already loaded
            if (weatherProvider.currentWeather == null) {
              weatherProvider.loadWeather(city: widget.city);
              return const CircularProgressIndicator();
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: Image.network(
                      "https:${weatherProvider.currentWeather!.conditionicon!}",
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text(weatherProvider.currentWeather.toString()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
