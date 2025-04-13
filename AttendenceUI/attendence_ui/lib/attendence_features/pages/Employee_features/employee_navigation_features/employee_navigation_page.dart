// import 'package:attendence_ui/attendence_features/pages/Employee_features/leaves_features/views/leave_page.dart';
// import 'package:attendence_ui/attendence_features/pages/Employee_features/my_activity_features/views/my_activitiy_page.dart';
// import 'package:attendence_ui/attendence_features/pages/Employee_features/task_features/views/task_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../Colors/colors.dart';
// import '../attendence_features/views/attendance_page.dart';
//
// class EmployeeNavigationPage extends StatefulWidget {
//   const EmployeeNavigationPage({super.key});
//
//   @override
//   State<EmployeeNavigationPage> createState() => _EmployeeNavigationPageState();
// }
//
// class _EmployeeNavigationPageState extends State<EmployeeNavigationPage> {
//   int _currentIndex = 0;
//
//   final List<Widget> _children = [
//     AttendancePage(),
//     MyActivitiyPage(),
//     TaskPage(),
//     LeavePage(),
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
//           buildNavItem('assets/icons/attendance_icon.svg', 'Attendance', 0),
//           buildNavItem('assets/icons/activity_icon.svg', 'My Activities', 1),
//           buildNavItem('assets/icons/task_icon.svg', 'Task', 2),
//           buildNavItem('assets/icons/leaves_icon.svg', 'Leaves', 3),
//         ],
//
//         selectedLabelStyle: TextStyle(fontSize: 8.sp),
//         unselectedLabelStyle: TextStyle(fontSize: 8.sp),
//         iconSize: 24.sp,
//       ),
//
//     );
//   }
//   BottomNavigationBarItem buildNavItem(String asset, String label, int index) {
//     return BottomNavigationBarItem(
//       icon: SvgPicture.asset(
//         asset,
//         color: _currentIndex == index ? Colors.white : Colors.white.withOpacity(0.4),
//       ),
//       label: label,
//     );
//   }
//
// }

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
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AttendancePage(),
    MyActivityPage(),
    TaskPage(),
    LeavePage(),
  ];
  final List<String> _iconPaths = [
    // 'assets/icons/face.png',
    // 'assets/icons/activity.png',
    // 'assets/icons/task.png',
    // 'assets/icons/leaves.png',

    'assets/icons/activity_employee.svg',
    'assets/icons/attendance_employee.svg',
    'assets/icons/task_employee.svg',
    'assets/icons/leaves_icon_employee.svg',
  ];

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _buildNavItem(0,  'Attendance'),
              _buildNavItem(1,  'My Activities'),
              _buildNavItem(2,  'Task'),
              _buildNavItem(3,  'Leaves'),
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
              fontSize: 11.sp,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }


}
