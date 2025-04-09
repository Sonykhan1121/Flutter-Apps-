import 'dart:typed_data';
import 'dart:convert';

import 'package:attendence_ui/attendence_features/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeeApiService {
  final String _baseUrl  = 'https://grozziie.zjweiting.com:3091/Attendance-System-Management';


  // create Employee (post)

  Future<void> createEmployee(Employee employee) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/dev/employee'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': employee.name,
        'employeeId': employee.employeeId,
        'designation': employee.designation,
        'address': employee.address,
        'email': employee.email,
        'contactNumber': employee.contactNumber,
        'deviceId': employee.deviceId,
        'salary': employee.salary,
        'overtimeRate': employee.overtimeRate,
        'startDate' :employee.startDate,
        'startTime' : employee.startTime,
        'embedding': employee.embedding,
        'imageFile': base64Encode(employee.imageFile), // Convert to Base64 string
      }),
    );

    if (response.statusCode == 201) {
      print('Employee created successfully');
    } else {
      print('Failed to create employee: ${response.statusCode}');
    }
  }
  Future<void> updateEmployee(Employee employee) async {

    final response = await http.put(
      Uri.parse('$_baseUrl/employees/${employee.employeeId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': employee.name,
        'employeeId': employee.employeeId,
        'designation': employee.designation,
        'address': employee.address,
        'email': employee.email,
        'contactNumber': employee.contactNumber,
        'salary': employee.salary,
        'overtimeRate': employee.overtimeRate,
        'embedding': employee.embedding,
        'imageFile': base64Encode(employee.imageFile),
      }),
    );




        if (response.statusCode == 200) {
          // Successful update
          print('Employee updated successfully!');
          // Optionally navigate back or clear the form
        } else if (response.statusCode == 409) {
          // Conflict - email already exists
         print('Error: Employee with this email already exists.');
        } else if (response.statusCode == 404) {
          // Not Found - employee ID does not exist
          print("Employee with ID ${employee.employeeId} not found.");
        } else {
          print('Response body: ${response.body}');
        }


  }

  Future<void> deleteEmployee(int id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/employees/$id'),
    );

    if (response.statusCode == 204) {
      print('Employee deleted successfully');
    } else {
      print('Failed to delete employee: ${response.statusCode}');
    }
  }
  Future<List<Employee>> getEmployees() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/dev/employee'));

    if (response.statusCode == 200) {

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> data = responseBody['data'];
    print("testing:${data.toString()}");
      return data.map((item) {
        final imageStr = item['imageFile'];
        final imageBytes = (imageStr != null && imageStr.length % 4 == 0 && imageStr != "string")
            ? base64Decode(imageStr)
            : Uint8List(0);

        final embeddingBytes = Float32List.fromList(List<double>.from(item['embedding']));

        return Employee.fromMap({
          'id': item['id'],
          'name': item['name'],
          'employeeId': item['employeeId'],
          'designation': item['designation'],
          'address': item['address'],
          'email': item['email'],
          'contactNumber': item['contactNumber'],
          'deviceId': item['deviceId'],
          'salary': item['salary'],
          'overtimeRate': item['overtimeRate'],
          'startDate': item['startDate'],
          'startTime': item['startTime'],
          'embedding': embeddingBytes,
          'imageFile': imageBytes,
        });
      }).toList();


    } else {
      throw Exception('Failed to load employees');
    }
  }
  Future<bool> checkEmployeeExist(String email) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/employees/check?email=$email'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['exists'] ?? false;
    } else {
      return false;
    }
  }
}