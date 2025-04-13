import 'dart:math' as math;

import 'package:attendence_ui/attendence_features/pages/device_connect_BluWifi_features/connect_device_page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:lottie/lottie.dart';

class DeviceSearchScreen extends StatefulWidget {

   const DeviceSearchScreen({super.key});

  @override
  State<DeviceSearchScreen> createState() => _DeviceSearchScreenState();
}

class _DeviceSearchScreenState extends State<DeviceSearchScreen> {
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startScan();
    // Listen for scan status
    FlutterBluePlus.isScanning.listen((isScanning) {
      setState(() {
        _isScanning = isScanning;
      });
    });

    // Listen for scan results
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        _scanResults = results;
      });
    }, onError: (e) {
      print("Scan error: $e");
    });



    Future.delayed(Duration(seconds: 20), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ConnectDevicePage2(scanResults: _scanResults)),
      );
    });

  }
  @override
  void dispose() {

    _stopScan();
    super.dispose();
  }

  Future<void> _startScan() async {
    print('startScan');

    _isScanning = true;
    try {
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
      );
      _isScanning = false;

    } catch (e) {
      print('Error starting scan: $e');
    }
  }

  Future<void> _stopScan() async {
    print('StopScan');
    _isScanning = false;

    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      print('Error stopping scan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {},
        ),
        title: const Text(
          'Find Device',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Lottie.asset('assets/animation/find.json'),

                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '20',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _isScanning ? 'Searching for devices...' : 'Search completed',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              '${_scanResults.length} devices found',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
