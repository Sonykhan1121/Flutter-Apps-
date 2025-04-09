
import 'package:attendence_ui/attendence_features/pages/device_connect_BluWifi_features/connect_device_page2.dart';
import 'package:attendence_ui/attendence_features/pages/device_connect_BluWifi_features/set_printer_wifi_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Colors/colors.dart';

class ConnectDevicePage extends StatelessWidget {
  const ConnectDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:  SvgPicture.asset("assets/icons/back.svg",height:20.h),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title:  Text(
          'Connect Device',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            _connectionTile(
              iconAsset: "assets/icons/bluetooth.svg",
              label: 'Connect Bluetooth',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ConnectDevicePage2()));
              },
            ),
            // const SizedBox(height: 12),
            // _connectionTile(
            //   iconAsset: "assets/icons/wifi.svg",
            //   label: 'Connect Wi-Fi',
            //   onTap: () {
            //     showDialog(
            //       context: context,
            //       builder: (_) =>  SetPrinterWifiDialog(),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _connectionTile({
    required String iconAsset,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Icon(icon, size: 22, color: Colors.black),
          SvgPicture.asset(iconAsset,height: 24.sp,),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style:  TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Cl.primaryColor,
              backgroundColor: Cl.primaryColor.withOpacity(0.05),
              elevation: 0,
              padding:  EdgeInsets.symmetric(horizontal: 20.sp, vertical: 7.sp),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            onPressed: onTap,
            child:  Text(
              'Connect',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}