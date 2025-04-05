import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkStatus {
  static Future<bool> inOnline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}