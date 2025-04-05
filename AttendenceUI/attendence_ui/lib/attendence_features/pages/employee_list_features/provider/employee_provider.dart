import 'dart:io';

import 'package:attendence_ui/attendence_features/services/network_status.dart';
import 'package:attendence_ui/attendence_features/services/pending_sync_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import '../../../database/userdatabase.dart';
import '../../../models/employee.dart';
import '../../../services/employee_api_service.dart';
// Assuming Employee class is in this file

class EmployeeProvider with ChangeNotifier {
  final UserDatabase _userDatabase = UserDatabase();
  final apiService = EmployeeApiService();

  List<Employee> _profiles =
      []; // Change from List<Map<String, dynamic>> to List<Employee>

  List<Employee> get profiles => _profiles;

  EmployeeProvider() {
    loadProfiles();
  }

  Future<void> loadProfiles() async {
    // Fetch all users from the database
    final users = await _userDatabase.getUsers();

    // Map users data to Employee objects using fromMap
    _profiles =
        users.map((user) {
          return Employee.fromMap(user);
        }).toList();

    // Notify listeners that the profiles have been updated
    notifyListeners();
  }

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
    // if (await NetworkStatus.inOnline()) {
    //   try {
    //     await apiService.createEmployee(employee);
    //   } catch (e) {
    //     print('Error sending user to server from provider');
    //   }
    // } else {
    //   PendingSyncService.addUsertoQueue(employee);
    // }

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
  Future<String?> getDeviceId() async {
    final DeviceInfoPlugin  deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid)
      {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.id;
      }
    else if(Platform.isIOS)
      {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor;
      }
    return null;
  }
}
