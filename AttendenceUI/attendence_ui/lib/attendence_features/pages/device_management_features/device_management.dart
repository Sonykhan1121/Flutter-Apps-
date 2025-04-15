import 'package:attendence_ui/attendence_features/pages/device_settings_features/views/device_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Colors/colors.dart';

class DeviceManagement extends StatefulWidget {
  const DeviceManagement({super.key});

  @override
  State<DeviceManagement> createState() => _DeviceManagementState();
}

class _DeviceManagementState extends State<DeviceManagement> {
  List<Map<String, String>> deviceList = [
    {
      'deviceName': 'iPhone 13 Pro',
      'macAddress': '00:1B:44:11:3A:B7'
    },
    {
      'deviceName': 'Samsung Galaxy S22',
      'macAddress': 'F8:E6:1A:D1:12:C4'
    },
    {
      'deviceName': 'MacBook Pro 16"',
      'macAddress': '3C:22:FB:63:54:E9'
    },
    {
      'deviceName': 'Dell XPS 15',
      'macAddress': '2A:F3:C1:B8:5D:7E'
    },
    {
      'deviceName': 'iPad Air',
      'macAddress': '1D:4B:32:A7:89:F2'
    },
    {
      'deviceName': 'Lenovo ThinkPad X1',
      'macAddress': '6C:5A:B5:E2:7F:14'
    },
    {
      'deviceName': 'Google Pixel 6',
      'macAddress': '9D:E7:AB:C3:46:21'
    },
    {
      'deviceName': 'HP Spectre x360',
      'macAddress': '5F:B1:C8:32:D9:A0'
    },
    {
      'deviceName': 'Microsoft Surface Pro',
      'macAddress': '8E:4A:D6:0F:93:B7'
    },
    {
      'deviceName': 'Sony Xperia 1 III',
      'macAddress': '2C:8D:1B:7E:6A:F3'
    },
    {
      'deviceName': 'ASUS ROG Gaming Laptop',
      'macAddress': '4A:F1:E3:9C:7B:D2'
    },
    {
      'deviceName': 'Acer Chromebook',
      'macAddress': '7B:3E:5D:C2:8F:A1'
    },
    {
      'deviceName': 'OnePlus 10 Pro',
      'macAddress': '1F:A2:E5:9D:4C:B6'
    },
    {
      'deviceName': 'LG Gram 17',
      'macAddress': '0E:D9:B4:3F:8C:75'
    },
    {
      'deviceName': 'Huawei MateBook X Pro',
      'macAddress': 'A1:C7:F3:4B:56:E8'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Device Management"),
        centerTitle: true,
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(height: 10.h,);
          },
        padding: EdgeInsets.all(12),
          itemCount: deviceList.length,
          itemBuilder: (context, index) {
            return  Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset("assets/icons/telephone.svg",height:40.h),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deviceList[index]["deviceName"]!,
                          style:  TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,

                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          deviceList[index]["macAddress"]!,
                          style:  TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DeviceSettingsPage()));

                    },
                      child: SvgPicture.asset('assets/icons/management_settings.svg',height:24.sp ,)),
                  SizedBox(width: 10.w,),
                ],
              ),
            );
          },
      ),
    );
  }
}
