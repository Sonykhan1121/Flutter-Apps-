
import 'package:attendence_ui/attendence_features/pages/add_employee_features/views/addemployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Colors/colors.dart';
import 'daily_attendence_features/views/dailyattendence.dart';
import 'device_settings_features/views/device_setting_screen.dart';
import 'employee_list_features/views/employee_list.dart';
import 'homepage_features/views/homebar.dart';



class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeBar(),
    DailyAttendance(),
    AddEmployee(),
    EmployeeList(),
    DeviceSettingsScreen(),
  ];
  final List<String> _iconPaths = [
    'assets/icons/home_admin.svg',
    'assets/icons/attendance_admin.svg',
'assets/icons/add_employee_admin.svg',
    'assets/icons/employee_admin.svg',
    'assets/icons/management_admin.svg',

  ];

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.only(bottom: 10.h, left: 15.h, right: 15.h),
        child: Container(
          height: 70.h,
          decoration: BoxDecoration(
            color: Cl.primaryColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0,  'Home'),
              _buildNavItem(1,  'Attendance'),
              _buildNavItem(2,  'Add Employee'),

              _buildNavItem(3,  'Employee List'),
              _buildNavItem(4,  'Management'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index,  String label) {
    final isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => onTabTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              _iconPaths[index],
              width: 20.h,
              height: 22.w,
              color: isSelected ?Color(0xFFD6E6F0) : Color(0xFF537B92),
            ),
          ),

          Text(
            label,
            style: TextStyle(
              color: isSelected ?Color(0xFFD6E6F0) : Color(0xFF537B92),
              fontSize: 10.sp,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }


}










