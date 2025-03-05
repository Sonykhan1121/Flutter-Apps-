import 'package:attendence_ui/signUpandLoginUser_features/pages/tabviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../widgets/date_picker.dart';

class DailyAttendence extends StatefulWidget {
  const DailyAttendence({super.key});

  @override
  _DailyAttendanceState createState() => _DailyAttendanceState();
}

class _DailyAttendanceState extends State<DailyAttendence> with SingleTickerProviderStateMixin {

  DateTime selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Attendance",style: TextStyle(fontSize: 20.sp,color: Colors.black.withOpacity(0.6)),),
        centerTitle: true,


      ),
      body: Column(
        children:[
          DatePicker(selectedDate: selectedDate, onSelectDate: (newDate) {
            setState(() {
              selectedDate = newDate;
            });
          }),
          Expanded(
            child:TabViews(),
          ),
        ]

      ),
    );
  }
}

