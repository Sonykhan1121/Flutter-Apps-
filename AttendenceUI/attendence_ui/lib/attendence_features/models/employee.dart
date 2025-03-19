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
  List<double> embedding;
  Uint8List imageFile;

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

  // Factory constructor to create Employee from Map
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      employeeId: map['employeeId'],
      designation: map['designation'],
      address: map['address'],
      email: map['email'],
      contactNumber: map['contactNumber'],
      salary: map['salary'],
      overtimeRate: map['overtimeRate'],
      embedding: List<double>.from(map['embedding']), // Assuming embedding is stored as List<double>
      imageFile: map['imageFile'], // Assuming imageFile is stored as Uint8List (binary data)
    );
  }

  // Method to convert Employee to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employeeId': employeeId,
      'designation': designation,
      'address': address,
      'email': email,
      'contactNumber': contactNumber,
      'salary': salary,
      'overtimeRate': overtimeRate,
      'embedding': embedding, // Assuming embedding is a List<double>
      'imageFile': imageFile, // Assuming imageFile is Uint8List (binary data)
    };
  }
}
