import 'package:attendence_ui/attendence_features/pages/Employee_features/employee_navigation_features/employee_navigation_page.dart';
import 'package:attendence_ui/attendence_features/pages/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Colors/colors.dart';
import '../qr_scanner_features/qr_scanner_page.dart';

class DeviceConnect extends StatefulWidget {
  const DeviceConnect({super.key});

  @override
  State<DeviceConnect> createState() => _DeviceConnectState();
}

class _DeviceConnectState extends State<DeviceConnect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Device Setup'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 15),
            Wrap(
              spacing: 16, // Horizontal space between items
              runSpacing: 16, // Vertical space between items
              // Center align items
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => NavigationPage()));
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => QRScannerPage()),
                    // );
                  },
                  child: Container(
                    width: 155.w,
                    height: 181.h,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/employee_profile/qr-code.svg',
                          width: 60.w,
                          height: 60.h,
                          color: Cl.primaryColor,
                        ),
                        SizedBox(height: 18),
                        Text(
                          'Connect Device',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Cl.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 155.w,
                  height: 181.h,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/employee_profile/qr-code.svg',
                        width: 60.w,
                        height: 60.h,
                        color: Cl.primaryColor,
                      ),
                      SizedBox(height: 18),
                      Text(
                        'Manual Connect',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Cl.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => EmployeeNavigationPage()));
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => QRScannerPage()),
                    // );
                  },
                  child: Container(
                    width: 155.w,
                    height: 181.h,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/employee_profile/qr-code.svg',
                          width: 60.w,
                          height: 60.h,
                          color: Cl.primaryColor,
                        ),
                        SizedBox(height: 18),
                        Text(
                          'Scan Qr Code',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Cl.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
