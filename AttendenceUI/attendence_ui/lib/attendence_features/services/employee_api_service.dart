import 'dart:convert';

import 'package:attendence_ui/attendence_features/models/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeApiService {
  final String _baseUrl  = 'https://your-server.com';


  // create Employee (post)

  Future<void> createEmployee(Employee employee) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/employees'),
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
        'imageFile': base64Encode(employee.imageFile), // Convert to Base64 string
      }),
    );

    if (response.statusCode == 201) {
      print('Employee created successfully');
    } else {
      print('Failed to create employee: ${response.statusCode}');
    }
  }
  Future<void> updateEmployee(int id, Employee employee) async
  {
    final response = await http.put(
      Uri.parse('$_baseUrl/employees/$id'),
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
      print('Employee updated successfully');
    } else {
      print('Failed to update employee: ${response.statusCode}');
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
    final response = await http.get(Uri.parse('$_baseUrl/employees'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Employee.fromMap(item)).toList();
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