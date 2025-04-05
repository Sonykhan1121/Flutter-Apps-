import 'package:flutter/material.dart';

import '../../../database/userdatabase.dart';
import '../../../models/employee.dart';
import '../../../services/employee_api_service.dart';
// Assuming Employee class is in this file

class EmployeeProvider with ChangeNotifier {
  final UserDatabase _userDatabase = UserDatabase();
  final apiService   = EmployeeApiService();

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

  // Future<void> loadProfiles() async {
  //   try {
  //     // Fetch all users from the server using the API
  //     List<Employee> apiProfiles = await apiService.getEmployees();
  //
  //     // Get all users from the local database
  //     final localUsers = await _userDatabase.getUsers();
  //
  //     // Check and sync data: Compare local and server data based on email
  //     for (var apiProfile in apiProfiles) {
  //       bool emailExistsLocally = localUsers.any((user) => user['email'] == apiProfile.email);
  //
  //       if (emailExistsLocally) {
  //         // Update the local user if there's a mismatch
  //         await _userDatabase.updateUser(apiProfile); // Update logic to update the user in the local DB
  //       } else {
  //         // Insert the user into the local database
  //         await _userDatabase.insertUser(apiProfile.toMap());
  //       }
  //     }
  //
  //     // After syncing, update the profiles list
  //     _profiles = apiProfiles;
  //
  //     // Notify listeners that the profiles have been updated
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error loading profiles: $e');
  //     // Handle any error cases, e.g., if the API call fails
  //   }
  // }

  Future<bool> emailExists(String email) async {
    return await _userDatabase.emailExists(email);
  }
  Future<bool> emailExistsinServer(String email) async {
    return await apiService.checkEmployeeExist(email);
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
    // add to server
    // await apiService.createEmployee(employee);

    // Reload profiles after inserting the new user
    await loadProfiles();
  }


  Future<void> deleteEmployee(int id) async {
    await _userDatabase.deleteUser(id);
    // await apiService.deleteEmployee(id);

    await loadProfiles();
  }

  Future<void> editEmployee(int id, String oldName, String newName) async {
    await _userDatabase.updateUser(id, oldName, newName);

    // await apiService.updateEmployee(id, updatedEmployee);

    await loadProfiles();
  }
}
