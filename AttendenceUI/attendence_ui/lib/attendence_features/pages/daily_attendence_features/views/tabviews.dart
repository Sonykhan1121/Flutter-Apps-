import 'package:attendence_ui/attendence_features/pages/daily_attendence_features/views/absent_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Colors/colors.dart';
import 'attendence_list_screen.dart';


class TabViews extends StatefulWidget {
  @override
  _DailyAttendanceState createState() => _DailyAttendanceState();
}

class _DailyAttendanceState extends State<TabViews> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          
          preferredSize: Size.fromHeight(26.h),
          child: TabBar(
            controller: _tabController,

            tabs: [
              // Tab(text: 'Present',),
              Tab(text: 'Absent'),
              Tab(text: 'Overtime'),

            ],
            unselectedLabelColor: Cl.primaryColor.withOpacity(0.6) ,
            labelStyle: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),
            labelColor: Cl.primaryColor,



            // Better spacing
            
          ),
        ),

      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // AttendanceListScreen(status: 'Present'),
          AbsentListScreen(status: "Absent"),
          AttendanceListScreen(status: 'Overtime'),
        ],
      ),
    );
  }
}

