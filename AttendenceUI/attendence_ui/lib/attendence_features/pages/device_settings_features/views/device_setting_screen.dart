import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Colors/colors.dart';

class DeviceSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Device Setup'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
              [
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
                      // Replace with your own asset
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
                      // Replace with your own asset
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
              ]
          )
        ],
      ),
    );
  }
}
