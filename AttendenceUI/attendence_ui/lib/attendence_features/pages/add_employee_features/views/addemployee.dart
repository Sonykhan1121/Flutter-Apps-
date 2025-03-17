import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Colors/colors.dart';
import 'face_detection_screen.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
   File? _image;



  Future<void> _pickImage() async {
    try {
      final imgFile = await Navigator.push<File?>(
        context,
        MaterialPageRoute(builder: (context) => FaceDetectionScreen()),
      );

      if (imgFile == null) {
        Fluttertoast.showToast(msg: "⚠️ No image selected!", backgroundColor: Colors.orange);
        return;
      }

      // final croppedFace = await cropFace(imgFile);
      setState(() => _image =imgFile); // Use cropped face or original

      if (_image == null) {
        Fluttertoast.showToast(msg: "⚠️ Face not detected properly!", backgroundColor: Colors.orange);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "⚠️ Error picking image: $e", backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Cl.primaryColor.withOpacity(0.6)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Employee',
          style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 20.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(

        padding: EdgeInsets.all(16),
        child: Column(

          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                clipBehavior: Clip.none, // Allow overlapping
                children: [
                  // Circular Profile Avatar
                  Container(
                    width: 158.w,
                    height: 158.h,
                    
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.w,color: Cl.primaryColor),
                      shape: BoxShape.circle,
                      image: _image!=null?DecorationImage(image: FileImage(_image!)):null,
                      
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent, // Top color
                          Cl.primaryColor.withOpacity(0.6), // Bottom quarter color
                        ],
                        stops: [0.75, 1.0], // 75% is blue, 25% is red
                      ),
                    ),
                    child: Center(
                      child: Icon(_image==null?Icons.person:null, color: Colors.blue.shade900, size: 100.sp),
                    ),
                  ),
                  // Camera Icon Positioned at Bottom-Center
                  Positioned(
              
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 30,
                        height: 20,
                        decoration: BoxDecoration(
                          // border: Border.all(width: 1),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Input Fields
            buildTextField("Full Name", "Full Name"),
            buildTextField("Employee ID", "AB000000000"),
            buildTextField("Designation", "Designation"),
            buildTextField("Address", "Employee Address"),
            buildTextField("Email Address", "employee@gmail.com"),
            buildTextField("Contact Number", "+00 12345 67890"),
            buildTextField("Salary", "\$1000"),
            buildTextField("Overtime Rate", "\$10"),

            SizedBox(height: 20),

            // Recognize Face Button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: "This is a Toast message",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                icon: SvgPicture.asset(
                  "assets/icons/button_icon.svg",  // Path to your SVG
                  width: 20.w,  // Set size
                  height: 20.h,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),  // Set color
                ),
                label: Text("Save Employee", style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF004368),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.w),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // TextField Widget
  Widget buildTextField(String label, String placeholder) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.sp,color: Cl.primaryColor, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          TextFormField(
            decoration: InputDecoration(
              hintText: placeholder,
              labelStyle: TextStyle(fontSize: 12.sp,color: Colors.black.withOpacity(0.6)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(color: Color(0x66004368)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

