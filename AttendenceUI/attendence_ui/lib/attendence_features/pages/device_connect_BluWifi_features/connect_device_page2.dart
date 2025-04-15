import 'package:attendence_ui/attendence_features/pages/device_connect_BluWifi_features/input_password_dialog.dart';
import 'package:attendence_ui/attendence_features/pages/device_searching_features/device_search_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg", height: 20.h),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Connect Device"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/icons/reload.svg", height: 20.h),

            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DeviceSearchScreen()));
            },
          ),
        ],
      ),
      body:
          widget.scanResults.isEmpty
              ? Center(child: Text('No Device found'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: widget.scanResults.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DeviceCard(
                      
                      name: widget.scanResults[index].device.platformName.isEmpty?"Unknown Device":widget.scanResults[index].device.platformName.toString(),
                      mac:
                          widget.scanResults[index].device.remoteId
                              .toString(),
                      isConnected: widget.scanResults[index].device.isConnected,
                      onTap: () {


                        showDialog(
                          context: context,
                          builder:
                              (context) =>
                                  widget.scanResults[index].device.isConnected
                                      ? InputPasswordDialog()
                                      : ConfirmPasswordDialog(),
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
