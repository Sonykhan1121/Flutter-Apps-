

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Colors/colors.dart';
import 'add_employee_features/views/addemployee.dart';
import 'daily_attendence_features/views/dailyattendence.dart';
import 'employee_list_features/views/employee_list.dart';
import 'homepage_features/views/homebar.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
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









class DeviceSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Device Settings Screen'));
  }
}
