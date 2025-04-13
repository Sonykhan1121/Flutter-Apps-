import 'package:attendence_ui/attendence_features/pages/device_connect_BluWifi_features/input_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'confirm_password_dialog.dart';
import 'device_card.dart';

class ConnectDevicePage2 extends StatefulWidget {
  List<ScanResult> scanResults;

  ConnectDevicePage2({required this.scanResults});
  @override
  State<ConnectDevicePage2> createState() => _ConnectDevicePage2State();
}

class _ConnectDevicePage2State extends State<ConnectDevicePage2> {
  final List<Map<String, dynamic>> devices = [
    {'name': 'Device Name', 'mac': '12a45c51a34sd2', 'connected': false},
    {'name': 'Device Name', 'mac': '98a2b4c51e45gf6', 'connected': false},
    {'name': 'Device Name', 'mac': 'A1b2c3f4d5e6g7h', 'connected': true},
    {'name': 'Device Name', 'mac': '56h7j8k910m1n2o', 'connected': false},
    {'name': 'Device Name', 'mac': '12p3q4r5s6t7u8v', 'connected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:  SvgPicture.asset("assets/icons/back.svg",height:20.h),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Connect Device"),
        centerTitle: true,
        actions: [
          IconButton(
            icon:  SvgPicture.asset("assets/icons/reload.svg",height:20.h),




            onPressed: () {
              // handle refresh
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.scanResults.length,
        itemBuilder: (context, index) {

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: DeviceCard(
              name: widget.scanResults[index].device.toString(),
              mac: widget.scanResults[index].advertisementData.toString(),
              isConnected: widget.scanResults[index].device.isConnected,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => widget.scanResults[index].device.isConnected ?InputPasswordDialog(): ConfirmPasswordDialog(),
                );

              },
            ),
          );
        },
      ),
    );
  }
}