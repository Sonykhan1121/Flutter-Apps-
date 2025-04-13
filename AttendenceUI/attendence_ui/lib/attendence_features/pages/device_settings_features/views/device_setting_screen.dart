import 'package:attendence_ui/attendence_features/pages/qr_scanner_features/qr_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Colors/colors.dart';
import '../../Employee_management_features/employee_management.dart';
import '../../device_connect_BluWifi_features/connect_device_page2.dart';

class DeviceSettingsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> map = [
    {'icon': 'assets/icons/crowdfunding.svg', 'title': "Device management"},
    {'icon': 'assets/icons/check-list.svg', "title": "Employee management"},
    {'icon': 'assets/icons/task-daily-02.svg', "title": "Task management"},
    {'icon': 'assets/icons/document-validation.svg', "title": "Leave approval"},
    {
      'icon': 'assets/icons/leave_management.svg',
      "title": "Leave application management",
    },
    {'icon': 'assets/icons/apple-reminder.svg', "title": "Rules"},
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(title: Text('Management'), centerTitle: true),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConnectDevicePage2()),
                );
              },
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConnectDevicePage2()),
                );
              },
              child: customRow(map[0]['icon'], map[0]['title']),
            ),
            Divider(height: 1.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeManagementScreen(),
                  ),
                );
              },
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeManagementScreen(),
                  ),
                );
              },
              child: customRow(map[1]['icon'], map[1]['title']),
            ),
            Divider(height: 1.h),

            customRow(map[2]['icon'], map[2]['title']),
            Divider(height: 1.h),

            customRow(map[3]['icon'], map[3]['title']),
            Divider(height: 1.h),

            customRow(map[4]['icon'], map[4]['title']),
            Divider(height: 1.h),

            customRow(map[5]['icon'], map[5]['title']),
            Divider(height: 1.h),
          ],
        ),
      ),
    );
  }

  Widget customRow(String svgAsset, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h, top: 15.h),
      child: Row(
        children: [
          SvgPicture.asset(svgAsset, height: 20.sp),
          SizedBox(width: 10.w),
          Text(title, style: TextStyle(fontSize: 14.sp), maxLines: 2),
        ],
      ),
    );
  }
}
