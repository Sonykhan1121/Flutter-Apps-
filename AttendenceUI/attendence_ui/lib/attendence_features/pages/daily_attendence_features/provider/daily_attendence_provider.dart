import 'package:flutter/material.dart';

class DailyAttendanceProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  final List<Map<String, String>> _attendList = [
    {"name": "Devon Lane", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg", "status": "Present"},
    {"name": "Theresa Webb", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg", "status": "Absent"},
    {"name": "Annette Black", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg", "status": "Overtime"},
    {"name": "Eleanor Pena", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg", "status": "Present"},
    {"name": "Kathryn Murphy", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg", "status": "Absent"},
  ];

  List<Map<String, String>> getAttendanceByStatus(String status) {
    return _attendList.where((person) => person['status'] == status).toList();
  }

  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }
}
