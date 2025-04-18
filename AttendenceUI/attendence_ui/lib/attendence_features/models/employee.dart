import 'dart:typed_data';

class Employee {
  int? id;
  String? name;
  String employeeId;
  String? designation;
  String? address;
  String email;
  String? contactNumber;
  String deviceId;
  double? salary;
  double? overtimeRate;
  String? startDate;
  String? startTime;

  List<double> embedding;
  Uint8List imageFile;

  Employee({
    this.id,
    this.name,
    required this.employeeId,
    this.designation,
    this.address,
    required this.email,
    this.contactNumber,
    required this.deviceId,
    this.salary,
    this.overtimeRate,
    this.startDate,
    this.startTime,
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
      deviceId: map['deviceId'],
      salary: map['salary'],
      overtimeRate: map['overtimeRate'],
      startDate: map['startDate'],
      startTime: map['startTime'],
      // Assuming startTime is stored as String (time in 24-hour format)
      embedding: List<double>.from(map['embedding']),
      // Assuming embedding is stored as List<double>
      imageFile:
      map['imageFile'], // Assuming imageFile is stored as Uint8List (binary data)
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
      'deviceId': deviceId,
      'salary': salary,
      'overtimeRate': overtimeRate,
      'startDate': startDate,
      'startTime': startTime,
      // Assuming startTime is stored as String (time in 12-hour format)
      'embedding': embedding,
      // Assuming embedding is a List<double>
      'imageFile': imageFile,
      // Assuming imageFile is Uint8List (binary data)
    };
  }
}
