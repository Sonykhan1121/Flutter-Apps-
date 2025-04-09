import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import '../../../database/userdatabase.dart';
import '../../../models/employee.dart';
import '../../../services/employee_api_service.dart';
// Assuming Employee class is in this file

class EmployeeProvider with ChangeNotifier {

  final UserDatabase _userDatabase = UserDatabase();
  final apiService = EmployeeApiService();
  bool _isLoading = false;

  List<Employee> _profiles =
      []; // Change from List<Map<String, dynamic>> to List<Employee>

  List<Employee> get profiles => _profiles;


  bool get isLoading => _isLoading;

  EmployeeProvider() {
    loadProfiles();
    print('loadProfile111');

    // syncFromServer();
  }

  Future<void> loadProfiles() async {
    _isLoading = true;
    // Fetch all users from the database


    final serverUsers = await apiService.getEmployees();
    await _userDatabase.clearUsers();

    for (final user in serverUsers) {
      await _userDatabase.insertUser(user.toMap());
    }

    // Map users data to Employee objects using fromMap

    final users = await _userDatabase.getUsers();
    _profiles =
        users.map((user) {
          return Employee.fromMap(user);
        }).toList();

_isLoading = false;

    // Notify listeners that the profiles have been updated
    notifyListeners();
  }

  // Future<void> syncFromServer() async {
  //   try {
  //     if (await NetworkStatus.inOnline()) {
  //       final serverUsers = await apiService.getEmployees();
  //
  //       // Optional: clear local DB and reinsert (if needed)
  //       await _userDatabase.clearUsers();
  //
  //       for (final user in serverUsers) {
  //         await _userDatabase.insertUser(user.toMap());
  //       }
  //     }
  //   } catch (e) {
  //     print('Error syncing from server: $e');
  //   }
  //
  //   // Always load from local DB to update UI
  //   await loadProfiles();
  // }


  Future<bool> emailExists(String email) async {
    return await _userDatabase.emailExists(email);
  }

  // Future<bool> emailExistsinServer(String email) async {
  //   return await apiService.checkEmployeeExist(email);
  // }

  Future<void> insertUser(Employee employee) async {
    // Convert the Employee object to a Map<String, dynamic>
    final Map<String, dynamic> map = employee.toMap();

    // Pass the map to the database insertion function
    await _userDatabase.insertUser(map);
    await apiService.createEmployee(employee);
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
  Future<void> updateEmployee(Employee employee) async {
    // await _userDatabase.updateUser(id, oldName, newName);

    await apiService.updateEmployee(employee);

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
