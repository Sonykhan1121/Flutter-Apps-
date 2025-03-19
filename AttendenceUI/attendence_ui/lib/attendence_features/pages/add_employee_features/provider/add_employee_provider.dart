import 'dart:io';
import 'dart:math';

import 'package:attendence_ui/attendence_features/database/userdatabase.dart';
import 'package:flutter/material.dart';

import '../../../services/face_embedder.dart';

class AddEmployeeProvider with ChangeNotifier {
  File? _image;

  File? get image => _image;
  final embedder = FaceEmbedder();
  final _db = UserDatabase();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController overtimeRateController = TextEditingController();

  void pickImage(File img) {
    _image = img;
    notifyListeners();
  }

  void clearFields() {
    // Clear all the fields
    nameController.clear();
    employeeIdController.clear();
    designationController.clear();
    addressController.clear();
    emailController.clear();
    contactController.clear();
    salaryController.clear();
    overtimeRateController.clear();
    _image = null;
  }

  Future<dynamic> getEmbedding() async {
    await embedder.initialize();
    if (_image == null) return null;

    return await embedder.getEmbedding(_image!);
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

  Map<String, dynamic> createUserMap({
    required String name,
    required String employeeId,
    required String designation,
    required String address,
    required String email,
    required String contactNumber,
    required String salary,
    required String overtimeRate,
    required dynamic embedding,
    required dynamic byteImage,
  }) {
    return {
      UserDatabase.columnName: name,
      UserDatabase.columnEmployeeId: employeeId,
      UserDatabase.columnDesignation: designation,
      UserDatabase.columnAddress: address,
      UserDatabase.columnEmail: email.toLowerCase(),
      UserDatabase.columnContactNumber: contactNumber,
      UserDatabase.columnSalary: double.parse(salary),
      UserDatabase.columnOvertimeRate: double.parse(overtimeRate),
      UserDatabase.columnEmbedding: embedding,
      UserDatabase.columnImageFile: byteImage,
    };
  }

  @override
  void dispose() {
    nameController.dispose();
    employeeIdController.dispose();
    designationController.dispose();
    addressController.dispose();
    emailController.dispose();
    contactController.dispose();
    salaryController.dispose();
    overtimeRateController.dispose();
    embedder.dispose();
    super.dispose();
  }
}
