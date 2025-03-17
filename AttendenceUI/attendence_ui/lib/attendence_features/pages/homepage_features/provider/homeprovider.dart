import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeBarProvider extends ChangeNotifier {


  final String userName = "Md G R Pias";
  final String userId = "ID: TG0642";
  final String profileImage = "assets/images/pias.png";
  final String selectedDate = "01 February 2025";

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


}
