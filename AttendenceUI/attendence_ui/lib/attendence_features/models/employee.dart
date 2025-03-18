import 'dart:typed_data';

class Employee {
  int? id;
  String name;
  String employeeId;
  String designation;
  String address;
  String email;
  String contactNumber;
  double salary;
  double overtimeRate;
  List<double> embedding; // Changed to List<double> to match the format
  Uint8List imageFile; // Changed to Uint8List for image file (binary data)

  Employee({
    this.id,
    required this.name,
    required this.employeeId,
    required this.designation,
    required this.address,
    required this.email,
    required this.contactNumber,
    required this.salary,
    required this.overtimeRate,
    required this.embedding,
    required this.imageFile,
  });
}