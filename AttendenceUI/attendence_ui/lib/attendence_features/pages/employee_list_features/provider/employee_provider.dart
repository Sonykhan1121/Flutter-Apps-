import 'package:flutter/material.dart';

import '../../../database/userdatabase.dart';
import '../../../models/employee.dart';
// Assuming Employee class is in this file

class EmployeeProvider with ChangeNotifier {
  final UserDatabase _userDatabase = UserDatabase();

  List<Employee> _profiles = []; // Change from List<Map<String, dynamic>> to List<Employee>

  List<Employee> get profiles => _profiles;

  EmployeeProvider() {
    loadProfiles();
  }

  Future<void> loadProfiles() async {
    // Fetch all users from the database
    final users = await _userDatabase.getUsers();

    // Map users data to Employee objects using fromMap
    _profiles = users.map((user) {
      return Employee.fromMap(user);
    }).toList();

    // Notify listeners that the profiles have been updated
    notifyListeners();
  }

  Future<bool> emailExists(String email) async {
    return await _userDatabase.emailExists(email);
  }

  Future<void> insertUser(Employee employee) async {
    // Convert the Employee object to a Map<String, dynamic>
    final Map<String, dynamic> map = {
      UserDatabase.columnName: employee.name,
      UserDatabase.columnEmployeeId: employee.employeeId,
      UserDatabase.columnDesignation: employee.designation,
      UserDatabase.columnAddress: employee.address,
      UserDatabase.columnEmail: employee.email,
      UserDatabase.columnContactNumber: employee.contactNumber,
      UserDatabase.columnSalary: employee.salary,
      UserDatabase.columnOvertimeRate: employee.overtimeRate,
      UserDatabase.columnEmbedding: employee.embedding,
      UserDatabase.columnImageFile: employee.imageFile,
    };

    // Pass the map to the database insertion function
    await _userDatabase.insertUser(map);

    // Reload profiles after inserting the new user
    await loadProfiles();
  }


  Future<void> deleteEmployee(int id) async {
    await _userDatabase.deleteUser(id);

    await loadProfiles();
  }

  Future<void> editEmployee(int id, String oldName, String newName) async {
    await _userDatabase.updateUser(id, oldName, newName);

    await loadProfiles();
  }
}
