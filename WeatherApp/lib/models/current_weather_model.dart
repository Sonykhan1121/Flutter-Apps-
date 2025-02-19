class CurrentWeatherModel {
  final String? location;
  final num? lastUpdatedEpoch;
  final String? lastUpdated;
  final num? tempC;
  final num? tempF;
  final num? isDay;
  final String? conditiontext;
  final String? conditionicon;
  final num? conditioncode;
  final num? windMph;
  final num? windKph;
  final int? windDegree;
  final String? windDir;
  final num? pressureMb;
  final num? pressureIn;
  final num? precipMm;
  final num? precipIn;
  final int? humidity;
  final int? cloud;
  final num? feelslikeC;
  final num? feelslikeF;
  final num? windchillC;
  final num? windchillF;
  final num? heatindexC;
  final num? heatindexF;
  final num? dewpointC;
  final num? dewpointF;
  final num? visKm;
  final num? visMiles;
  final num? uv;
  final num? gustMph;
  final num? gustKph;

  CurrentWeatherModel({
    this.location,
     this.lastUpdatedEpoch,
     this.lastUpdated,
     this.tempC,
     this.tempF,
     this.isDay,
       this.conditiontext,
      this.conditionicon,
     this.conditioncode,
     this.windMph,
     this.windKph,
     this.windDegree,
     this.windDir,
     this.pressureMb,
     this.pressureIn,
     this.precipMm,
     this.precipIn,
     this.humidity,
     this.cloud,
     this.feelslikeC,
     this.feelslikeF,
     this.windchillC,
     this.windchillF,
     this.heatindexC,
     this.heatindexF,
     this.dewpointC,
     this.dewpointF,
     this.visKm,
     this.visMiles,
     this.uv,
     this.gustMph,
     this.gustKph,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) => CurrentWeatherModel(
    location: json['location']['name'],
    lastUpdatedEpoch: json['current']['last_updated_epoch'],
    lastUpdated: json['current']['last_updated'],
    tempC: json['current']['temp_c'],
    tempF: json['current']['temp_f'],
    isDay: json['current']['is_day'],
    conditiontext: json['current']['condition']['text'],
    conditionicon: json['current']['condition']['icon'],
    conditioncode: json['current']['condition']['code'],
    windMph: json['current']['wind_mph'],
    windKph: json['current']['wind_kph'],
    windDegree: json['current']['wind_degree'],
    windDir: json['current']['wind_dir'],
    pressureMb: json['current']['pressure_mb'],
    pressureIn: json['current']['pressure_in'],
    precipMm: json['current']['precip_mm'],
    precipIn: json['current']['precip_in'],
    humidity: json['current']['humidity'],
    cloud: json['current']['cloud'],
    feelslikeC: json['current']['feelslike_c'],
    feelslikeF: json['current']['feelslike_f'],
    windchillC: json['current']['windchill_c'],
    windchillF: json['current']['windchill_f'],
    heatindexC: json['current']['heatindex_c'],
    heatindexF: json['current']['heatindex_f'],
    dewpointC: json['current']['dewpoint_c'],
    dewpointF: json['current']['dewpoint_f'],
    visKm: json['current']['vis_km'],
    visMiles: json['current']['vis_miles'],
    uv: json['current']['uv'],
    gustMph: json['current']['gust_mph'],
    gustKph: json['current']['gust_kph'],
  );




  @override
  String toString() {
    return 'Location: $location\nlastUpdatedEpoch: $lastUpdatedEpoch \n lastUpdated: $lastUpdated\n tempC: $tempC\n tempF: $tempF\n isDay: $isDay\n conditiontext: $conditiontext\n conditionicon: $conditionicon\n conditioncode: $conditioncode\n windMph: $windMph\n windKph: $windKph\n windDegree: $windDegree\n windDir: $windDir\n pressureMb: $pressureMb\n pressureIn: $pressureIn\n precipMm: $precipMm\n precipIn: $precipIn\n humidity: $humidity\n cloud: $cloud\n feelslikeC: $feelslikeC\n feelslikeF: $feelslikeF\n windchillC: $windchillC\n windchillF: $windchillF\n heatindexC: $heatindexC\n heatindexF: $heatindexF\n dewpointC: $dewpointC\n dewpointF: $dewpointF\n visKm: $visKm\n visMiles: $visMiles\n uv: $uv\n gustMph: $gustMph\n gustKph: $gustKph\n}';
  }
}
