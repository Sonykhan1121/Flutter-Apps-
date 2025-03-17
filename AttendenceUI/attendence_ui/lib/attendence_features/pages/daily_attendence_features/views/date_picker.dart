import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Colors/colors.dart';

class DatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onSelectDate;

  DatePicker({required this.selectedDate, required this.onSelectDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, top: 23.0,left: 25,right: 25),
      child: InkWell(
        onTap: () async {
          DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (newDate != null) {
            onSelectDate(newDate);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.calendar_month, color: Cl.primaryColor,size: 20.w,),
              SizedBox(width: 20.w,),
              Text(
                "${formatDate(selectedDate)}",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500,color: Cl.primaryColor),
              ),
              Spacer(),
              Icon(Icons.arrow_drop_down, color: Cl.primaryColor.withOpacity(0.6),),
            ],
          ),
        ),
      ),
    );
  }
  String formatDate(DateTime selectedDate) {
    return "${selectedDate.day.toString().padLeft(2, '0')} ${getMonthName(selectedDate.month)} ${selectedDate.year}";
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return ''; // Or throw an exception for invalid month
    }
  }
}