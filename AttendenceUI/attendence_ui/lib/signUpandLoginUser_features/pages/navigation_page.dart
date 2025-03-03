import 'package:attendence_ui/signUpandLoginUser_features/pages/addemployee.dart';
import 'package:attendence_ui/signUpandLoginUser_features/pages/dailyattendence.dart';
import 'package:attendence_ui/signUpandLoginUser_features/pages/face_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'employee_list.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    FaceAttendanceScreen(),
    DailyAttendence(),
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
        backgroundColor: Color(0xFF004368),
        unselectedItemColor: Colors.white.withOpacity(0.2),
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
        selectedLabelStyle: TextStyle(fontSize: 14),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        iconSize: 24,
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
