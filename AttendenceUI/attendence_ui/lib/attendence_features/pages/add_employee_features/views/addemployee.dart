import 'dart:io';
import 'dart:math';
import 'package:attendence_ui/attendence_features/pages/employee_list_features/provider/employee_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../Colors/colors.dart';

import '../../../database/userdatabase.dart';
import '../../../services/face_embedder.dart';
import '../provider/add_employee_provider.dart';
import 'face_detection_screen.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  String alreadyregisteruserName = "";
  bool _isProcessing = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AddEmployeeProvider>(context, listen: false);
  }

  Future<void> _registerUser(
    AddEmployeeProvider provider,
    BuildContext context,
  ) async {
    if (!_formKey.currentState!.validate() || provider.image == null) {
      Fluttertoast.showToast(
        msg: "⚠️ Please fill up all the fields",
        textColor: Colors.red,
        backgroundColor: Colors.white,
      );
      return;
    }

    setState(() => _isProcessing = true);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    await Future.delayed(Duration(seconds: 2));

    try {
      final db = UserDatabase();
      final employeeprovider = Provider.of<EmployeeProvider>(
        context,
        listen: false,
      );
      if (await db.emailExists(provider.emailController.text)) {
        Navigator.pop(context); // Close loading dialog
        Fluttertoast.showToast(
          msg: "Email already registered!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        setState(() => _isProcessing = false);
        return;
      }

      final embedder = FaceEmbedder();
      await embedder.initialize();
      final embedding = await embedder.getEmbedding(provider.image!);
      embedder.dispose();
      Uint8List? byteimage = await provider.image?.readAsBytes();
      if (await checkthisfacealreadyregisterorNot(embedding)) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'This face is already registered here.named:$alreadyregisteruserName');
        return;
      }

      final userId = await db.insertUser({
        UserDatabase.columnName: provider.nameController.text,
        UserDatabase.columnEmployeeId: provider.employeeIdController.text,
        UserDatabase.columnDesignation: provider.designationController.text,
        UserDatabase.columnAddress: provider.addressController.text,
        UserDatabase.columnEmail: provider.emailController.text.toLowerCase(),
        UserDatabase.columnContactNumber: provider.contactController.text,
        UserDatabase.columnSalary: double.parse(provider.salaryController.text),
        UserDatabase.columnOvertimeRate: double.parse(
          provider.overtimeRateController.text,
        ),
        UserDatabase.columnEmbedding: embedding,
        UserDatabase.columnImageFile: byteimage,
        // This remains the same, assuming 'embedding' is a List<double>
      });
      print('inserted');

      Navigator.pop(context); // Close loading dialog
      employeeprovider.loadProfiles();
      Fluttertoast.showToast(
        msg: "A new Employeed added Successfully",
        toastLength: Toast.LENGTH_LONG,
      );
      provider.clearFields();
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Registration failed: ${e.toString()}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<bool> checkthisfacealreadyregisterorNot(List<double> embedding) async {
    final _db = UserDatabase();
    String? matchedUserName;
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
      setState(() {
        alreadyregisteruserName = matchedUserName!;
      });
      return true;
    }
    return false;
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
  Widget build(BuildContext context) {
    // final provider = Provider.of<AddEmployeeProvider>(context);

    return Consumer<AddEmployeeProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Add Employee',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 20.sp,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final imgFile = await Navigator.push<File?>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FaceDetectionScreen(),
                        ),
                      );
                      if (imgFile != null) {
                        provider.pickImage(imgFile);
                      }
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 158.w,
                          height: 158.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.w,
                              color: Cl.primaryColor,
                            ),
                            shape: BoxShape.circle,
                            image:
                                provider.image != null
                                    ? DecorationImage(
                                      image: FileImage(provider.image!),
                                      fit: BoxFit.cover,
                                    )
                                    : null,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Cl.primaryColor.withOpacity(0.6),
                              ],
                              stops: [0.75, 1.0],
                            ),
                          ),
                          child: Center(
                            child:
                                provider.image == null
                                    ? Icon(
                                      Icons.person,
                                      color: Colors.blue.shade900,
                                      size: 100.sp,
                                    )
                                    : null,
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 30,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildTextField("Full Name", provider.nameController),
                  buildTextField("Employee ID", provider.employeeIdController),
                  buildTextField("Designation", provider.designationController),
                  buildTextField("Address", provider.addressController),
                  buildTextField("Email Address", provider.emailController),
                  buildTextField("Contact Number", provider.contactController),
                  buildTextField("Salary", provider.salaryController),
                  buildTextField(
                    "Overtime Rate",
                    provider.overtimeRateController,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton.icon(
                      onPressed:
                          _isProcessing
                              ? null
                              : () async {
                                await _registerUser(provider, context);
                              },
                      icon: SvgPicture.asset(
                        "assets/icons/button_icon.svg",
                        width: 20.w,
                        height: 20.h,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: Text(
                        "Save Employee",
                        style: TextStyle(fontSize: 15.sp, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004368),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.w),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Cl.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: label,
              labelStyle: TextStyle(
                fontSize: 12.sp,
                color: Colors.black.withOpacity(0.6),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 9,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: Color(0x66004368)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
            validator: (value) => validateInput(value, "required"),
          ),
        ],
      ),
    );
  }

  String? validateInput(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null; // Validation successful
  }
}
