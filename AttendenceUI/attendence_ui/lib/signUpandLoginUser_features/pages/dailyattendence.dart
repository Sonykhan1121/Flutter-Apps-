import 'package:attendence_ui/signUpandLoginUser_features/pages/tabviews.dart';
import 'package:flutter/material.dart';


import '../widgets/date_picker.dart';

class DailyAttendence extends StatefulWidget {
  @override
  _DailyAttendanceState createState() => _DailyAttendanceState();
}

class _DailyAttendanceState extends State<DailyAttendence> with SingleTickerProviderStateMixin {

  DateTime selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Attendance"),


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

