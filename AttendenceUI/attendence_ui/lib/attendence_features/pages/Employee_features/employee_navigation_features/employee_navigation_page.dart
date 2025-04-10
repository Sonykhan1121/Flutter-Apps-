import 'package:attendence_ui/attendence_features/pages/Employee_features/leaves_features/views/leave_page.dart';
import 'package:attendence_ui/attendence_features/pages/Employee_features/my_activity_features/views/my_activitiy_page.dart';
import 'package:attendence_ui/attendence_features/pages/Employee_features/task_features/views/task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Colors/colors.dart';
import '../attendence_features/views/attendance_page.dart';

class EmployeeNavigationPage extends StatefulWidget {
  const EmployeeNavigationPage({super.key});

  @override
  State<EmployeeNavigationPage> createState() => _EmployeeNavigationPageState();
}

class _EmployeeNavigationPageState extends State<EmployeeNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    AttendancePage(),
    MyActivitiyPage(),
    TaskPage(),
    LeavePage(),
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
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/attendance_icon.svg'), label: 'Attendance'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/activity_icon.svg'), label: 'My Activities'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/task_icon.svg'), label: 'Task'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/leaves_icon.svg'), label: 'Leaves'),
        ],
        selectedLabelStyle: TextStyle(fontSize: 8.sp),
        unselectedLabelStyle: TextStyle(fontSize: 8.sp),
        iconSize: 24.sp,
      ),

    );
  }
}
