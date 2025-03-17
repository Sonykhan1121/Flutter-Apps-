import 'package:flutter/material.dart';

class EmployeeProvider with ChangeNotifier {
  List<Map<String, dynamic>> _profiles = [
    {"name": "Devon Lane", "image": ""},
    {"name": "Alex Jane", "image": ""},
    {"name": "Sam Pat", "image": ""},
  ];

  List<Map<String, dynamic>> get profiles => _profiles;

  // Function to add an employee
  void addEmployee(String name, String image) {
    _profiles.add({"name": name, "image": image});
    notifyListeners();
  }

  // Function to delete an employee
  void deleteEmployee(String name) {
    _profiles.removeWhere((profile) => profile['name'] == name);
    notifyListeners();
  }

  // Function to update an employee's name or image
  void editEmployee(String oldName, String newName, String newImage) {
    var index = _profiles.indexWhere((profile) => profile['name'] == oldName);
    if (index != -1) {
      _profiles[index] = {"name": newName, "image": newImage};
      notifyListeners();
    }
  }
}
