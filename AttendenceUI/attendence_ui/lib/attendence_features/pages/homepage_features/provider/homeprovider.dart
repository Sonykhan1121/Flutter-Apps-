import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeBarProvider extends ChangeNotifier {

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  final String userName = "Md G R Pias";
  final String userId = "ID: TG0642";
  final String profileImage = "assets/images/pias.png";


  final List<Map<String, dynamic>> attendanceData = [
    {'title': 'Total Employee', 'count': '150', 'icon': LucideIcons.briefcase},
    {'title': 'Present Employee', 'count': '130', 'icon': LucideIcons.armchair},
    {'title': 'Absent Employee', 'count': '15', 'icon': LucideIcons.settings},
    {'title': 'Late Punch', 'count': '05', 'icon': LucideIcons.alarmClock},
  ];

  final List<Map<String, String>> leaveSummaryData = [
    {'title': 'Sick leave', 'count': '10 Person'},
    {'title': 'Casual leave', 'count': '2 Person'},
    {'title': 'Other leave', 'count': '1 Person'},
    {'title': 'Maternity leave', 'count': '1 Person'},
    {'title': 'Paternity leave', 'count': '1 Person'},
  ];
  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
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
