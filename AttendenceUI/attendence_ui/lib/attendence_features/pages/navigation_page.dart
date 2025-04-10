

import 'package:attendence_ui/attendence_features/pages/device_connect_BluWifi_features/connect_device_page.dart';
import 'package:attendence_ui/attendence_features/pages/qr_scanner_features/qr_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Colors/colors.dart';
import 'add_employee_features/views/addemployee.dart';
import 'daily_attendence_features/views/dailyattendence.dart';
import 'device_settings_features/views/device_setting_screen.dart';
import 'employee_list_features/views/employee_list.dart';
import 'homepage_features/views/homebar.dart';

class NavigationPage extends StatefulWidget {
  @override
  NavigationPageState createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeBar(),
    DailyAttendance(),
    AddEmployee(),
    EmployeeList(),
    DeviceSettingsScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Cl.primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.4),
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,

        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Add Employee'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Employee List'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Devices'),
        ],
        selectedLabelStyle: TextStyle(fontSize: 8.sp),
        unselectedLabelStyle: TextStyle(fontSize: 8.sp),
        iconSize: 24.sp,
      ),

    );
  }

}

// Dummy screen widgets for each tab









