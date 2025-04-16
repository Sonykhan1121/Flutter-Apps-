import 'dart:typed_data';
import 'dart:io';
import 'dart:math';

import 'package:attendence_ui/attendence_features/database/userdatabase.dart';
import 'package:attendence_ui/attendence_features/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../services/face_embedder.dart';

class AddEmployeeProvider with ChangeNotifier {

  final List<String> designations = [
    'Project Manager',
    'Product Manager',
    'Team Lead',
    'Software Engineer',
    'QA Engineer',
    'UX/UI Designer',
    'Business Analyst',
    'HR Executive',
    'HR Manager',
    'Worker',
    'Marketing Manager',
    'Sales Executive',
    'Finance Manager',
    'Customer Support',
    'Intern',
    'Junior Developer',
    'DevOps Engineer',
    'Database Administrator',
    'Security Analyst',

  ];
  final List<String> deviceNames = [
    // Android devices
    'Pixel 6',
    'Pixel 7 Pro',
    'Samsung Galaxy S21',
    'Samsung Galaxy S22 Ultra',
    'OnePlus 9',
    'OnePlus 11',
    'Xiaomi Mi 11',
    'Redmi Note 11',
    'Realme GT Neo',
    'Asus ROG Phone 5',
    'Motorola Edge 30',

    // iOS devices
    'iPhone 13',
    'iPhone 13 Pro',
    'iPhone 14',
    'iPhone 14 Pro Max',
    'iPhone SE (3rd generation)',
    'iPad Air (5th generation)',
    'iPad Pro 12.9-inch (6th generation)',
    'iPhone 15',
    'iPhone 15 Pro',


  ];

  File? _image;

  File? get image => _image;
  final embedder = FaceEmbedder();
  final _db = UserDatabase();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
   String _designation ="Project Manager" ;
   String _device ="Pixel 6" ;
  int _employeeIdStart = 5040;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController overtimeRateController = TextEditingController();


  String get device => _device;
  void set_device(String dev)
  {
    _device = dev;
    notifyListeners();
  }

  void pickImage(File? img) {
    _image = img;
    notifyListeners();
  }
  void set_designation(String des)
  {
    _designation = des;
    notifyListeners();
  }
  String get designation => _designation;

  void clearFields() {
    // Clear all the fields
    nameController.clear();
    employeeIdController.clear();
    addressController.clear();
    _designation ="Project Manager" ;
    emailController.clear();
    contactController.clear();
    salaryController.clear();
    overtimeRateController.clear();
    _device = "Pixel 6";
    _image = null;
  }
  void setAllTextController(Employee employee) async
  {
    nameController.text = employee.name!;
    employeeIdController.text = employee.employeeId;

    addressController.text = employee.address!;
    emailController.text = employee.email;
    contactController.text = employee.contactNumber!;
    salaryController.text = employee.salary.toString();
    overtimeRateController.text = employee.overtimeRate.toString();
    _image = await convertUint8ListToFile(employee.imageFile);
  }
  Future<File> convertUint8ListToFile(Uint8List data) async {
    // Get the directory for storing the file (e.g., documents directory)
    Directory directory = await getApplicationDocumentsDirectory();

    // Generate a unique file name (e.g., using a timestamp)
    String fileName = 'file_${DateTime.now().millisecondsSinceEpoch}.bin';

    // Create the full file path
    String filePath = '${directory.path}/$fileName';

    // Create a File object
    File file = File(filePath);

    // Write the Uint8List data to the file
    await file.writeAsBytes(data);

    print('File saved at: $filePath');
    return file;
  }

  Future<dynamic> getEmbedding() async {
    await embedder.initialize();
    if (_image == null) return null;

    return await embedder.getEmbedding(_image!);
  }
  Future<dynamic> getEmbeddingfromfile(File? imgFile) async {
    if(imgFile==null) {
      return null;
    }
    await embedder.initialize();


    return await embedder.getEmbedding(imgFile);
  }

  Future<dynamic> ImagetoByteImage() async {
    if (_image == null) return null;

    return await _image!.readAsBytes();
  }

  Future<String?> checkFaceAlreadyRegisterOrNot(List<double> embedding) async {
    String? matchedUserName = null;
    final users = await _db.getUsers();
    double maxSimilarity = 0.0;
    for (var user in users) {
      List<double> storedEmbedding = user[UserDatabase.columnEmbedding];
      double similarity = _calculateSimilarity(embedding, storedEmbedding);

      if (similarity > maxSimilarity) {
        maxSimilarity = similarity;
        matchedUserName = user[UserDatabase.columnName];
      }
    }
    if (maxSimilarity >= 0.7 && matchedUserName != null) {
      return matchedUserName;
    }
    return null;
  }

  double _calculateSimilarity(List<double> emb1, List<double> emb2) {
    double dotProduct = 0.0, normA = 0.0, normB = 0.0;
    for (int i = 0; i < emb1.length; i++) {
      dotProduct += emb1[i] * emb2[i];
      normA += emb1[i] * emb1[i];
      normB += emb2[i] * emb2[i];
    }

    return dotProduct / (sqrt(normA) * sqrt(normB));
  }



  @override
  void dispose() {
    nameController.dispose();
    employeeIdController.dispose();

    addressController.dispose();
    emailController.dispose();
    contactController.dispose();
    salaryController.dispose();
    overtimeRateController.dispose();
    embedder.dispose();
    super.dispose();
  }

  int get employeeIdStart => _employeeIdStart;

  void setEmployeeId() {
    _employeeIdStart++;
    notifyListeners();
  }
}
