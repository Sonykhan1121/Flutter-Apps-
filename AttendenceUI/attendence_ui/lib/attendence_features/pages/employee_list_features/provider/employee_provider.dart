import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../database/userdatabase.dart';
 // Assuming UserDatabase class is imported from the file above

class EmployeeProvider with ChangeNotifier {
  final UserDatabase _userDatabase = UserDatabase();

  List<Map<String, dynamic>> _profiles = [
    {
      "name": "test1",
      "image": null, // Assuming 'image' field contains a valid file path
    },
    {
      "name": "test2",
      "image": null, // Assuming 'image' field contains a valid file path
    },
    {
      "name": "test3",
      "image": null, // Assuming 'image' field contains a valid file path
    },
  ];

  List<Map<String, dynamic>> get profiles => _profiles;
  EmployeeProvider()
  {
    loadProfiles();
  }

  // Load profiles from database
  Future<void> loadProfiles() async {
    final users = await _userDatabase.getUsers();
    _profiles.addAll(users.map((user) {
      return {
        "name": user['name'],
        "image": user['imageFile'], // Assuming 'image' field contains a valid file path
      };
    }).toList());
    notifyListeners();
  }

  // Function to add an employee


  // Function to delete an employee
  Future<void> deleteEmployee(String name) async {
    // Remove the employee from the database


    // Reload profiles from the database
    await loadProfiles();
  }

  // Function to update an employee's name or image
  Future<void> editEmployee(String oldName, String newName, File newImage) async {
    if (newImage == null) {
      throw Exception("Image cannot be null");
    }

    // Convert the new image to BLOB
    final newImageBytes = await newImage.readAsBytes();

    // Update the employee data in the database


    // Reload profiles from the database
    await loadProfiles();
  }
}
