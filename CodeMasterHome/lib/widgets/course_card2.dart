import 'package:codemasterhome/models/course_model.dart';
import 'package:codemasterhome/widgets/stylish_webview.dart';
import 'package:flutter/material.dart';

import '../utils/appColors.dart';
import '../utils/appScale.dart';

class CourseCard2 extends StatelessWidget {
  final CourseModel courseModel;
  final String buttontext;
  final String url;
  const CourseCard2({required this.courseModel,required this.buttontext, required this.url,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the card
          borderRadius: BorderRadius.circular(15), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 2), // Shadow offset
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Image and Course Title
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                courseModel.image_asset!, // Replace with your image asset
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16), // Spacing between image and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    courseModel.title!,
                    style: TextStyle(
                      fontFamily: "Noto Serif",
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: AppScale.scaleText(16, context),
                    ),
                  ),
                ],
              ),
            ),
            // Right side: Continue Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>StylishWebview(url: url,title: courseModel.title,)));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: AppColors.secondary, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(buttontext,
                style: TextStyle(
                  fontFamily: "Noto Serif",
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: AppScale.scaleText(14, context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

