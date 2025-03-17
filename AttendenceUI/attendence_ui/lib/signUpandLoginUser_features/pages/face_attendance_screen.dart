import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../Colors/colors.dart';

class FaceAttendanceScreen extends StatelessWidget {
  const FaceAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print("$height X $width");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Face Attendance',
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40.w,
                    backgroundImage: AssetImage("assets/images/pias.png"),
                  ),
                  SizedBox(width: 14.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Md G R Pias',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'ID: TG0642',
                        style: TextStyle(
                          fontSize: 12.w,
                          color: Cl.primaryColor.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Attendance Overview',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Cl.primaryColor,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_month,color: Cl.primaryColor,),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("01 February 2025",style: TextStyle(fontSize: 12.sp),),

                        Icon(Icons.chevron_right,color: Cl.primaryColor.withOpacity(0.6),),
                      ],
                    ),
                    // Add a trailing icon by placing it inside the label as a Row
                    style: ElevatedButton.styleFrom(

                      backgroundColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              Divider(height: 2.h),
              SizedBox(height: 20.h),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: (width<430)?1.1:1.3,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  attendanceCard('Total Employee', '150', LucideIcons.briefcase),
                  attendanceCard('Present Employee', '130', LucideIcons.armchair),
                  attendanceCard('Absent Employee', '15', LucideIcons.settings),
                  attendanceCard('Late Punch', '05', LucideIcons.alarmClock),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'Leave Summary',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Cl.primaryColor,
                ),
              ),
              SizedBox(height: 20.h),
              Divider(height: 2.h),
              SizedBox(height: 15.h),
              leaveSummary('Sick leave', '10 Person'),
              leaveSummary('Casual leave', '2 Person'),
              leaveSummary('Other leave', '1 Person'),
              leaveSummary('Maternity leave', '1 Person'),
              leaveSummary('Paternity leave', '1 Person'),
            ],
          ),
        ),
      ),
    );
  }

  Widget attendanceCard(String title, String count, IconData icon) {
    return Container(
      width: 158.w,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: get_IconColor(icon).withOpacity(0.1),
            ),
            child: Icon(icon, size: 20.sp, color: get_IconColor(icon)),
          ),
          SizedBox(height: 16.h),
          Text(title, style: TextStyle(fontSize: 12.sp, color: Colors.black)),
          SizedBox(height: 4.h),
          Text(
            count,
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }


  Color get_IconColor(IconData icon) {
    switch (icon) {
      case LucideIcons.briefcase:
        return Cl.primaryColor;
      case LucideIcons.armchair:
        return Cl.secondaryColor;
      case LucideIcons.settings:
        return Cl.secondaryColor;
      case LucideIcons.alarmClock:
        return Cl.thirdColor;
      default:
        return Colors.black;
    }
  }

  Widget leaveSummary(String title, String count) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 12.sp, color: Colors.black)),
            Text(
              count,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
