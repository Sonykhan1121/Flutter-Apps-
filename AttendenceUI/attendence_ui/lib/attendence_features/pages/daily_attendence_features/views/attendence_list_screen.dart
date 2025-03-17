import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider/daily_attendence_provider.dart';

class AttendanceListScreen extends StatelessWidget {
  final String status;

  const AttendanceListScreen({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Consumer<DailyAttendanceProvider>(
      builder: (context, attendanceProvider, child) {
        final List<Map<String, String>> data = attendanceProvider.getAttendanceByStatus(status);

        return ListView.builder(
          padding: EdgeInsets.only(top: 29, left: 25, right: 25),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(
              height: 60.h,
              margin: EdgeInsets.symmetric(vertical: 6),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: Color(0x1A004368)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25.h,
                    backgroundImage: NetworkImage(data[index]['image']!),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      data[index]['name']!,
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ),
                  Icon(Icons.more_vert, size: 24.w),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
