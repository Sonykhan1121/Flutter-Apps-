import 'package:flutter/material.dart';

class WeatherUpdateUnavailableWidget extends StatefulWidget {

  @override
  _WeatherUpdateUnavailableWidgetState createState() =>
      _WeatherUpdateUnavailableWidgetState();
}

class _WeatherUpdateUnavailableWidgetState
    extends State<WeatherUpdateUnavailableWidget> {
  bool isDataAvailable = false;

  void refreshWeatherData() {
    // Simulate data refresh by toggling the isDataAvailable flag
    setState(() {
      isDataAvailable = !isDataAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDataAvailable
        ? Container(
      child: Text('Weather Data not Available!'),
    )
        : Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off,
            size: 50,
            color: Colors.white.withOpacity(0.5),
          ),
          SizedBox(height: 10),
          Text(
            "Weather update currently unavailable. Please check back later!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: refreshWeatherData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent, // Soft green button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text('Refresh'),
          ),
        ],
      ),
    );
  }
}