
import 'package:attendence_ui/attendence_features/pages/daily_attendence_features/views/tabviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import '../provider/daily_attendence_provider.dart';
import 'date_picker.dart';

class DailyAttendance extends StatelessWidget {
  const DailyAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Daily Attendance", style: TextStyle(fontSize: 20.sp, color: Colors.black.withOpacity(0.6))),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Consumer<DailyAttendanceProvider>(
        builder: (context, attendanceProvider, child) {
          return Column(
            children: [
              DatePicker(),
              Expanded(child: TabViews()),
            ],
          );
        },
      ),
    );
  }
}
