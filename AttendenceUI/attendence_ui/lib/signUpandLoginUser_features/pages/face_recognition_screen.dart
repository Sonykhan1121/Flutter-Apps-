import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FaceRecognitionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Face recognize",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade500,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Please complete face verification to securely confirm your identity.\n"
                "Your privacy is protected, and this ensures safe access to your account.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 8, color: Colors.black),
              ),
            ),

            // Circular image with dotted border
            Stack(
              alignment: Alignment.center,
              children: [
                // Dotted border
                DottedBorder(
                  color: Color(0xFF00FB46),
                  borderType: BorderType.Oval,
                  strokeWidth: 6,
                  dashPattern: [5,3],
                  child: Container(
                    width: 276, // Set explicit width
                    height: 398, // Set explicit height
                  ),
                ),

                // Image inside the circle
                ClipOval(
                  child: Image.asset(
                    "assets/images/profile.png",
                    width: 266,  // Slightly smaller than border
                    height: 388,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            // Instruction text
            Text(
              "Keep your face in center",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),

            SizedBox(height: 30),

            // Enroll Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF004368), // Dark blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Enroll Employee",
                    style: TextStyle(fontSize: 15, color: Colors.white),
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
