
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    EmployeeList(),
    DeviceSettingsScreen(),
  ];
  final List<String> _iconPaths = [
    'assets/icons/home_icon.png',
    'assets/icons/attendance_admin.png',
    'assets/icons/Profile.png',
    'assets/icons/device_admin.png',
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

      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.only(bottom: 10.h, left: 15.h, right: 15.h),
        child: Container(
          height: 70.h,
          decoration: BoxDecoration(
            color: Color(0xFFF4F8FF),
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
              _buildNavItem(2,  'Employee List'),
              _buildNavItem(3,  'Devices'),
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
            // decoration: BoxDecoration(
            //   // color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
            //   borderRadius: BorderRadius.circular(12),
            // ),
            child: Image.asset(
              _iconPaths[index],
              width: 20.sp,
              height: 22.sp,
              color: isSelected ?Color(0xFF004368) : Color(0xFF537B92),
            ),
          ),

          Text(
            label,
            style: TextStyle(
              color: isSelected ?Color(0xFF004368) : Color(0xFF537B92),
              fontSize: 11.sp,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }


}

//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../Colors/colors.dart';
// import 'daily_attendence_features/views/dailyattendence.dart';
// import 'device_settings_features/views/device_setting_screen.dart';
// import 'employee_list_features/views/employee_list.dart';
// import 'homepage_features/views/homebar.dart';
//
// class NavigationPage extends StatefulWidget {
//   @override
//   NavigationPageState createState() => NavigationPageState();
// }
//
// class NavigationPageState extends State<NavigationPage> {
//   int _currentIndex = 0;
//
//   final List<Widget> _children = [
//     HomeBar(),
//     DailyAttendance(),
//     EmployeeList(),
//     DeviceSettingsScreen(),
//   ];
//
//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       backgroundColor: Colors.white,
//       body: _children[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Cl.primaryColor,
//         unselectedItemColor: Colors.white.withOpacity(0.4),
//         selectedItemColor: Colors.white,
//         currentIndex: _currentIndex,
//
//         onTap: onTabTapped,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'Attendance'),
//           BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Employee List'),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Devices'),
//         ],
//         selectedLabelStyle: TextStyle(fontSize: 8.sp),
//         unselectedLabelStyle: TextStyle(fontSize: 8.sp),
//         iconSize: 24.sp,
//       ),
//
//     );
//   }
//
// }

// Dummy screen widgets for each tab









