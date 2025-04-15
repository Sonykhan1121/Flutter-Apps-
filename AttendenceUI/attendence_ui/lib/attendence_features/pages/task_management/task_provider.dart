import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier{

  final List<Map<String, dynamic>> _tasks = [
    {"title": "Design Landing Page", "assign_employee_count": 3},
    {"title": "Database Optimization", "assign_employee_count": 2},
    {"title": "Mobile App UI Revamp", "assign_employee_count": 5},
    {"title": "Write Unit Tests", "assign_employee_count": 4},
    {"title": "Client Meeting Preparation", "assign_employee_count": 1},
    {"title": "Bug Fixing Sprint", "assign_employee_count": 6},
    {"title": "Marketing Campaign Plan", "assign_employee_count": 2},
    {"title": "Code Review & Merge", "assign_employee_count": 3},
  ];
  void addTasks(String title, int countEmployee)
  {
    _tasks.add({"title": title, "assign_employee_count": countEmployee});
    notifyListeners();
  }

  List<Map<String, dynamic>> get tasks => _tasks;
}