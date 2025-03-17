import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Colors/colors.dart';

class FaceRecognitionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Cl.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Face recognize",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 57.h),

            // Description
            Text(
              "Please complete face verification to securely confirm your identity.\n"
              "Your privacy is protected, and this ensures safe access to your account.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 8.sp, color: Colors.black),
            ),

            // Circular image with dotted border
            Stack(
              alignment: Alignment.center,
              children: [
                // Dotted border
                DottedBorder(
                  color: Color(0xFF00FB46),
                  borderType: BorderType.Oval,
                  strokeWidth: 7.w,
                  dashPattern: [5,3],
                  child: Container(
                    width: 276.h, // Set explicit width
                    height: 398.h, // Set explicit height
                  ),
                ),

                // Image inside the circle
                ClipOval(
                  child: Image.asset(
                    "assets/images/profile.png",
                    width: 266.h,  // Slightly smaller than border
                    height: 388.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            // Instruction text
            Text(
              "Keep your face in center",
              style: TextStyle(fontSize: 12.sp, color: Colors.black),
            ),

            SizedBox(height: 30),

            // Enroll Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Cl.primaryColor, // Dark blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                  ),
                  child: Text(
                    "Enroll Employee",
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
