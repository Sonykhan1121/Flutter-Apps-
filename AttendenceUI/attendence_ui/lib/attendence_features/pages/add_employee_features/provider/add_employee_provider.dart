import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEmployeeProvider with ChangeNotifier {
  File? _image;
  File? get image => _image;


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
  void clearFields()
  {
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
    super.dispose();
  }
}
